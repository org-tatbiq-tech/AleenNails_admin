const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Cloud tasks initialization
const { CloudTasksClient } = require('@google-cloud/tasks')

admin.initializeApp();
let path = require('path');
let crypto = require('crypto');

// Macros
const appointmentsCollection = "appointments";
const clientsCollection = "clients";
const adminsCollection = "admins";
const notificationsCollection = "notifications";
const adminAppTitle = "Aleen Nails Admin";
const clientAppTitle = "Aleen Nails";

// Cloud tasks initialization
const project = JSON.parse(process.env.FIREBASE_CONFIG).projectId
// Cloud functions info
const cloudFunctionsLocation = "us-central1"
const notificationsTasksCallbackName = "notificationsTasksCallback"
// Queue info
const tasksQueueLocation = "europe-central2"
const queue = "tasks-queue"


// Tasks functions
async function submitTask(payload, scheduleTime, taskCallbackName) {
    const tasksClient = new CloudTasksClient();
    const queuePath = tasksClient.queuePath(project, tasksQueueLocation, queue);
    // Testing Url:
    //           `https://us-central1-aleenclienttest.cloudfunctions.net/notificationsTasksCallback`
    const url = `https://${cloudFunctionsLocation}-${project}.cloudfunctions.net/${taskCallbackName}`;
    let task = {
        httpRequest: {
            httpMethod: 'POST',
            url,
            body: Buffer.from(JSON.stringify(payload)).toString('base64'),
            headers: {
                'Content-Type': 'application/json',
            },
            oidcToken: {
              serviceAccountEmail: "aleennail-prod@appspot.gserviceaccount.com",
            },
        },
        scheduleTime: {
          seconds: scheduleTime
        }
    };

    try {
        return await tasksClient.createTask({ parent: queuePath, task });
    } catch (error) {
        console.log('Failed creating new reminder task', error);
    }
    return [];
}

async function generateReminderTask(appointmentId, appointmentDate, tokensDict, isClient) {
    let reminders = [];

    // Day before
    let day_before_msg = 'תזכורת לתור שלך מחר אצל אלין! ';
    day_before_msg += formatDate(appointmentDate.toDate());
    let title = isClient ? clientAppTitle : adminAppTitle;
    let dayBeforeDate = appointmentDate.toDate();
    dayBeforeDate.setHours(dayBeforeDate.getHours()-24);
    let payload = {
        msg: day_before_msg,
        title: title,
        isClient: isClient,
        tokens: tokensDict,
        additionalInfo: {
            appointment_id: appointmentId,
            category: 'NotificationCategory.appointment',
        }
    }
//    let d = new Date();
//    d.setMinutes(d.getMinutes()+3);
    if(dayBeforeDate > new Date()) {
//    if(d > new Date()) {
        let [response] = await submitTask(payload, dayBeforeDate.getTime()/1000, notificationsTasksCallbackName);
//        let [response] = await submitTask(payload, d.getTime()/1000, notificationsTasksCallbackName);
        if (response) {
            console.log('reminder task name:', response.name);
            reminders.push(response.name)
        }
    }

    // 2 hours before
    let two_hours_before_msg = 'תזכורת לתור שלך עוד שעתיים אצל אלין! ';
    two_hours_before_msg += formatDate(appointmentDate.toDate());
    let twoHoursBeforeDate = appointmentDate.toDate();
    twoHoursBeforeDate.setHours(twoHoursBeforeDate.getHours()-2);
    payload = {
        msg: two_hours_before_msg,
        title: title,
        isClient: isClient,
        tokens: tokensDict,
        additionalInfo: {
            appointment_id: appointmentId,
            category: 'NotificationCategory.appointment',
        }
    }
//    let d2 = new Date();
//    d2.setMinutes(d2.getMinutes()+2);
    if(twoHoursBeforeDate > new Date()) {
//    if(d2 > new Date()) {
          [response] = await submitTask(payload, twoHoursBeforeDate.getTime()/1000, notificationsTasksCallbackName);
//        [response] = await submitTask(payload, d2.getTime()/1000, notificationsTasksCallbackName);
        if (response) {
            console.log('reminder 2 task name:', response.name);
            reminders.push(response.name)
        }
    }
    // Update appointment reminders tasks list
    console.log('updating appointment', appointmentId)
    const docRef  = await admin.firestore().collection(appointmentsCollection).doc(appointmentId);
    await docRef.update({
        reminders: reminders
    });
}

async function cancelReminderTask(appointmentId, appointmentData) {
    if (appointmentData.reminders) {
        const tasksClient = new CloudTasksClient()
        for (reminderTask of appointmentData.reminders) {
            console.log('cancelling task', reminderTask);
            try {
                await tasksClient.deleteTask({ name: reminderTask });
            } catch (error) {
                console.log('error cancelling task', error);
            }
        }
    }
    const docRef  = await admin.firestore().collection(appointmentsCollection).doc(appointmentId);
    await docRef.update({
        reminders: []
    });
}

// Notifications handler from tasks queue
async function notificationsTasksHandler(req, res) {
    const payload = req.body;
    console.log(payload)
    try {
        const notificationContent = {
            notification: {
               title: payload.title,
               body: payload.msg,
               sound: 'default'
           },
           data: {
               ...payload.additionalInfo,
           }
       };

       if (payload.isClient) {
            console.log('Sending task notification to client');
            console.log(payload.tokens);
            await sendClientNotification(payload.tokens, notificationContent);
       } else {
            console.log('Sending task notification to to admin');
            await sendAdminNotification(payload.tokens, notificationContent);
       }
       res.send(200);
    }
    catch (error) {
        console.error(error)
        res.status(500).send(error)
    }
}

function formatDate(date) {
     return date.toLocaleString('he-IL', { timeZone:'Asia/Jerusalem', year: 'numeric', month: 'short', day: 'numeric', 'hour': '2-digit', minute: '2-digit' })
}

function isClient(editor) {
    return editor === 'AppointmentCreator.client';
}

function isBusiness(editor) {
    return editor === 'AppointmentCreator.business';
}

async function getClientTokens(clientDocID) {
    const clientResults  = await admin.firestore().collection(clientsCollection).doc(clientDocID).get();
    const client = clientResults.data();
    let clientTokens = {};
    if (client['tokens']) {
        clientTokens[clientDocID] = client['tokens'];
    }
    return clientTokens;
}

async function getAdminTokens() {
    let adminTokens = {};
    const adminResults  = await admin.firestore().collection(adminsCollection).get();
    for (adminDoc of adminResults.docs) {
        const adminData = adminDoc.data();
        adminTokens[adminDoc.id] = adminData['tokens'];
    }
    return adminTokens;
}

function getNotificationRecord(notificationContent) {
    return {
        ...notificationContent,
        creationDate:  admin.firestore.Timestamp.now(),
        isOpened: false
    }
}

function getServicesMessage(services) {
    if(!(services && services.length > 0)) {
        // return 'no services';
        return 'אין שירותים';
    }
    let message = services[0]['name'];
    if (services.length > 1) {
        // message += ' + more';
        message += ' + עוד';
    }
    return message;
}

function getClientDetailsFromAppointment(appointment) {
    return {
        client_id: appointment.clientDocID,
        client_image_url: appointment.clientImageURL
    }
}

async function addNotificationToDb(collectionName, documentId, notificationContent) {
    const notificationsCollectionRef  = await admin.firestore().collection(collectionName).doc(documentId).collection(notificationsCollection);
    let docRef = await notificationsCollectionRef.add(getNotificationRecord(notificationContent));
    let newNotificationContent = {
        ...notificationContent
    }
    newNotificationContent['data'] = {
        ...newNotificationContent['data'],
        'notification_id': docRef.id
    };
    return newNotificationContent;
}

async function sendClientNotification(clientTokensDict, notificationContent) {
    for (const clientDocumentId in clientTokensDict) {
        if(clientTokensDict[clientDocumentId]) {
            let newNotificationContent = await addNotificationToDb(clientsCollection, clientDocumentId, notificationContent);
            await admin.messaging().sendToDevice(clientTokensDict[clientDocumentId], newNotificationContent);
        }
    }
}

async function sendAdminNotification(adminTokensDict, notificationContent) {
    for (const adminDocumentId in adminTokensDict) {
        let newNotificationContent = await addNotificationToDb(adminsCollection, adminDocumentId, notificationContent);
        await admin.messaging().sendToDevice(adminTokensDict[adminDocumentId], newNotificationContent);
    }
}

// Update the admin when client creates new appointment and update the client when
// admin creates new appointment for him
async function handleNewAppointment(snap, context) {
    // Getting details of the new document
    const appointmentId = context.params.appointmentId;
    const newAppointmentData = snap.data();
    const clientDocID = newAppointmentData.clientDocID;
    const clientTokens = await getClientTokens(clientDocID);
    if(clientTokens) {
         console.log('Send Message to schedule reminder');
         await generateReminderTask(appointmentId, newAppointmentData.date, clientTokens, true);
    }
    if ( isClient(newAppointmentData.creator) ) {
       console.log('Appointment created by client. need to notify the admin');
       // const clientName = newAppointmentData.clientName;
       const clientName = newAppointmentData.clientName;
       // let msg = 'You have a new appointment! ' + formatDate(newAppointmentData.date.toDate());
       // msg += ' ' + clientName + ' • ' + getServicesMessage(newAppointmentData.services);
       let msg = 'יש לך תור חדש! ';
       msg += formatDate(newAppointmentData.date.toDate());
       msg += ' ' + clientName + ' • ';
       msg += getServicesMessage(newAppointmentData.services);
       let clientDetails = getClientDetailsFromAppointment(newAppointmentData);
       const notificationContent = {
           notification: {
               title: adminAppTitle,
               body: msg,
               sound: 'default'
           },
           data: {
               ...clientDetails,
               appointment_id: appointmentId,
               category: 'NotificationCategory.appointment',
           }
       };
       const adminTokens = await getAdminTokens();
       await sendAdminNotification(adminTokens, notificationContent);
       return;
    }
    if ( isBusiness(newAppointmentData.creator) ) {
        console.log('Appointment created by business. need to notify the client');
        if(clientTokens) {
            // let msg = 'You have a new appointment! ' + formatDate(newAppointmentData.date.toDate());
            // msg += ' • ' + getServicesMessage(newAppointmentData.services);
            let msg = 'יש לך תור חדש! ';
            msg += formatDate(newAppointmentData.date.toDate());
            msg += ' • ';
            msg += getServicesMessage(newAppointmentData.services);
            const notificationContent = {
                notification: {
                   title: clientAppTitle,
                   body: msg,
                   sound: 'default'
               },
               data: {
                   appointment_id: appointmentId,
                   category: 'NotificationCategory.appointment',
               }
           };
            console.log('Sending notification to ', newAppointmentData.clientName);
            await sendClientNotification(clientTokens, notificationContent);
            return;
        }
    }
}

async function handleUpdateAppointment(change, context) {
    // Get the updated object representing the updated document
    const newValue = change.after.data();
    const appointmentId = change.after.id;
    // Get the previous object before this updated document
    const previousValue = change.before.data();
    // check the editor
    const changedByClient = isClient(newValue.lastEditor);
    const changedByBusiness = isBusiness(newValue.lastEditor);
    const clientDocID = newValue.clientDocID;
    const clientName = newValue.clientName;
    if (!changedByClient && !changedByBusiness){
        console.log('last editor is not defined');
        return;
    }
    // Check if appointment rescheduled
    if (!newValue.date.isEqual(previousValue.date)) {
        let title = "";
        let msg = "";
        let clientDetails = {};
        const clientTokens = await getClientTokens(clientDocID);
        if(clientTokens) {
            // will not send cancel schedule reminder since we can't control the order of the messages
            // and because it will be overridden by the new scheduled notification for using the same id
             console.log('Send Message to schedule reminder');
             await cancelReminderTask(appointmentId, newValue);
             await generateReminderTask(appointmentId, newValue.date, clientTokens, true);
        }
        if (changedByClient) {
            title = adminAppTitle;
            // msg = 'An appointment has been rescheduled to ' + formatDate(newValue.date.toDate());
            // msg += ' ' + clientName + ' • ' + getServicesMessage(newValue.services);
            msg = 'התור נדחה ל ';
            msg += formatDate(newValue.date.toDate());
            msg += ' ';
            msg += clientName + ' • ';
            msg += getServicesMessage(newValue.services);
            clientDetails = getClientDetailsFromAppointment(newValue);
        } else {
            title = clientAppTitle;
            // msg = 'Aleen Nails rescheduled your appointment to ' + formatDate(newValue.date.toDate());
            msg = 'אלין דחתה את התור שלך ל ';
            msg += formatDate(newValue.date.toDate());
        }

        const notificationContent = {
            notification: {
              title: title,
              body: msg,
              sound: 'default'
            },
            data: {
              ...clientDetails,
              appointment_id: appointmentId,
              category: 'NotificationCategory.appointment',
            }
        };
        console.log('Send notification about the rescheduled appointment')
        if (changedByClient) {
            const adminTokens = await getAdminTokens();
            await sendAdminNotification(adminTokens, notificationContent);
            return;
        } else {
            if(clientTokens) {
                console.log('Sending notification to ', newValue.clientName)
                await sendClientNotification(clientTokens, notificationContent);
                return;
            }
        }
    }
    if (newValue.status != previousValue.status) {
        if(newValue.status === 'AppointmentStatus.confirmed') {
            console.log('Send notification about confirmed appointment');
            // const msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' has been confirmed';
            let msg = 'התור שלך עם אלין ב ';
            msg += formatDate(newValue.date.toDate());
            msg += ' ';
            msg += 'אושר בהצלחה';
            const notificationContent = {
               notification: {
                 title: clientAppTitle,
                 body: msg,
                 sound: 'default'
               },
               data: {
                 appointment_id: appointmentId,
                 category: 'NotificationCategory.appointment',
               }
           };
           const clientTokens = await getClientTokens(clientDocID);
           if(clientTokens) {
               console.log('Sending notification to ', newValue.clientName);
               await sendClientNotification(clientTokens, notificationContent);
               return;
           }
        }
        if(newValue.status === 'AppointmentStatus.declined') {
            console.log('Send notification about declined appointment')
            // const msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' can not be scheduled please contact Aleen';
            let msg = 'התור שלך עם אלין ב ';
            msg += formatDate(newValue.date.toDate());
            msg += ' ';
            msg += 'לא הושלם בהצלחה נא ליצור קשר עם אלין';
            const notificationContent = {
               notification: {
                 title: clientAppTitle,
                 body: msg,
                 sound: 'default'
               },
               data: {
                 appointment_id: appointmentId,
                 category: 'NotificationCategory.appointment',
               }
           };
           const clientTokens = await getClientTokens(clientDocID);
           if(clientTokens) {
               console.log('Sending notification to ', newValue.clientName);
               await sendClientNotification(clientTokens, notificationContent);
               console.log('Send Message to cancel old scheduled reminder');
               await cancelReminderTask(appointmentId, newValue);
               return;
           }
        }

        if(newValue.status ==='AppointmentStatus.cancelled') {
            console.log('Notify that appointment is canceled');
            let title = "";
            let msg = "";
            let clientDetails = {};
            if (changedByClient) {
                title = adminAppTitle;
                // msg = 'An appointment has been canceled ' + formatDate(newValue.date.toDate());
                // msg += ' ' + clientName + ' • ' + getServicesMessage(newValue.services);
                msg = 'תור בוטל ב ';
                msg += formatDate(newValue.date.toDate());
                msg += ' ';
                msg += clientName + ' • ';
                msg += getServicesMessage(newValue.services);
                clientDetails = getClientDetailsFromAppointment(newValue);
            } else {
                title = clientAppTitle;
                msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' has been canceled';
                msg = 'התור שלך עם אלין ב ';
                msg += formatDate(newValue.date.toDate());
                msg += ' ';
                msg += 'בוטל';
            }
            const notificationContent = {
                notification: {
                  title: title,
                  body: msg,
                  sound: 'default'
                },
                data: {
                  ...clientDetails,
                  appointment_id: appointmentId,
                  category: 'NotificationCategory.appointment',
                }
            };
            const clientTokens = await getClientTokens(clientDocID);
            if(clientTokens) {
                console.log('Send Message to cancel old scheduled reminder');
                await cancelReminderTask(appointmentId, newValue);
            }
            console.log('Send notification about the canceled appointment')
            if (changedByClient) {
                const adminTokens = await getAdminTokens();
                await sendAdminNotification(adminTokens, notificationContent);
                return;
            } else {
                if(clientTokens) {
                    console.log('Sending notification to ', newValue.clientName);
                    await sendClientNotification(clientTokens, notificationContent);
                    return;
                }
            }
        }
    }
}

async function handleUpdateClient(change, context) {
    // Getting details of the new document
    const newClient = change.after.data();
    const clientId = change.after.id;
    // Get the previous object before this updated document
    const oldClient = change.before.data();
    if(!oldClient.phone && newClient.phone) {
        // phone number is now verified, we need to notify the admin to approve/deny the new client
        console.log('Notify the admin about new created user', newClient.fullName);
        // const msg = 'New registration request from ' + newClient.fullName + ' • please approve/deny';
        let msg = 'בקשה חדשה להירשמות למערכת מ ';
        msg += newClient.fullName;
        msg += ' • ';
        msg += 'נא לאשר/לדחות';
        const notificationContent = {
            notification: {
              title: adminAppTitle,
              body: msg,
              sound: 'default'
            },
            data: {
              client_id: clientId,
              client_image_url: newClient.imageURL,
              category: 'NotificationCategory.user',
            }
        };
        const adminTokens = await getAdminTokens();
        await sendAdminNotification(adminTokens, notificationContent);
        return;
    }
// // Disabled the following code because for now we don't need to check with auth if user exist
// // because we add phone only after otp
//    try {
//        let userRecord = await admin.auth().getUser(clientId);
//        if(userRecord) {
//            // The new client record created by user that was registered by himself
//            // Need to notify the admins
//            console.log('Notify the admin about new created user', newClientData.fullName);
//            const title = newClientData.fullName + ' registered to the system';
//            const msg = 'please approve or deny ' + newClientData.fullName + ' registration';
//            const notificationContent = {
//                notification: {
//                  title: title,
//                  body: msg,
//                  sound: 'default'
//                },
//                data: {
//                  client_id: clientId,
//                  category: 'NotificationCategory.user',
//                }
//            };
//            const adminTokens = await getAdminTokens();
//            SEND NOTIFICATION
//        }
//    } catch (e) {
//        if (e.code === 'auth/user-not-found') {
//            // user created by admin
//            console.log('User not found in firebase auth');
//        } else {
//            //TBD: we should send email to the dev team
//            console.log('throw this unknown error');
//            console.log(e);
//            throw e; // re-throw the error unchanged
//        }
//    }
}


// Handle new appointment
exports.newAppointment = functions.firestore.
    document('appointments/{appointmentId}').
    onCreate(handleNewAppointment);

// Handle update appointment
exports.updateAppointment = functions.firestore.
    document('appointments/{any}').
    onUpdate(handleUpdateAppointment);

// Handle update client
exports.updateClient = functions.firestore.
    document('clients/{any}').
    onUpdate(handleUpdateClient);

exports.notificationsTasksCallback = functions.https.onRequest(notificationsTasksHandler);