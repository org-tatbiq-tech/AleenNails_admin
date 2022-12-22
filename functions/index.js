const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
var path = require('path');

// Macros
const appointmentsCollection = "appointments";
const clientsCollection = "clients";
const adminsCollection = "admins";
const notificationsCollection = "notifications";
const adminAppTitle = "Aleen Nails Admin";
const clientAppTitle = "Aleen Nails";

function getMonthStr(date) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[date.getMonth()];
}

function getDayStr(date) {
    return date.getDate().toString();
}

function getYearStr(date) {
    return date.getFullYear();
}

function getTimeStr(date) {
    return date.getHours() + ":" + ("0" + date.getMinutes()).slice(-2);
}

function formatDate(date) {
    let localDate =  new Date(date.toLocaleString('en-US', { timeZone: 'Asia/Jerusalem'}));
    return getMonthStr(localDate) + " " + getDayStr(localDate) + "," + getYearStr(localDate) + " " + getTimeStr(localDate);
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
        return 'no services';
    }
    let message = services[0]['name'];
    if (services.length > 1) {
        message += ' + more'
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
    if ( isClient(newAppointmentData.creator) ) {
       console.log('Appointment created by client. need to notify the admin');
       const clientName = newAppointmentData.clientName ?? 'Client';
       let msg = 'You have a new appointment! ' + formatDate(newAppointmentData.date.toDate());
       msg += ' ' + clientName + ' • ' + getServicesMessage(newAppointmentData.services);
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
        const clientTokens = await getClientTokens(clientDocID);
        if(clientTokens) {
            let msg = 'You have a new appointment! ' + formatDate(newAppointmentData.date.toDate());
            msg += ' • ' + getServicesMessage(newAppointmentData.services);
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
    if (!changedByClient && !changedByBusiness){
        console.log('last editor is not defined');
        return;
    }
    // Check if appointment rescheduled
    if (!newValue.date.isEqual(previousValue.date)) {
        let title = "";
        let msg = "";
        let clientDetails = {};
        if (changedByClient) {
            title = adminAppTitle;
            msg = 'An appointment has been rescheduled to ' + formatDate(newValue.date.toDate());
            msg += ' ' + clientName + ' • ' + getServicesMessage(newValue.services);
            clientDetails = getClientDetailsFromAppointment(newValue);
        } else {
            title = clientAppTitle;
            msg = 'Aleen Nails rescheduled your appointment to ' + formatDate(newValue.date.toDate());
            // msg += ' and required additional confirmation'
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
            const clientTokens = await getClientTokens(clientDocID);
            if(clientTokens) {
                console.log('Sending notification to ', newValue.clientName)
                await sendClientNotification(clientTokens, notificationContent);
                return;
            }
        }
    }
    if (newValue.status != previousValue.status) {
        if(newValue.status === 'AppointmentStatus.confirmed') {
            console.log('Send notification about confirmed appointment')
            const msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' has been confirmed';
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
            const msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' can not be scheduled please contact Aleen';
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

        if(newValue.status ==='AppointmentStatus.cancelled') {
            console.log('Notify that appointment is canceled');
            let title = "";
            let msg = "";
            let clientDetails = {};
            if (changedByClient) {
                title = adminAppTitle;
                msg = 'An appointment has been canceled ' + formatDate(newValue.date.toDate());
                msg += ' ' + clientName + ' • ' + getServicesMessage(newValue.services);
                clientDetails = getClientDetailsFromAppointment(newValue);
            } else {
                title = clientAppTitle;
                msg = 'Your appointment with Aleen Nails on ' + formatDate(newValue.date.toDate()) + ' has been canceled';
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
            console.log('Send notification about the canceled appointment')
            if (changedByClient) {
                const adminTokens = await getAdminTokens();
                await sendAdminNotification(adminTokens, notificationContent);
                return;
            } else {
                const clientTokens = await getClientTokens(clientDocID);
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
        const msg = 'New registration request from ' + newClient.fullName + ' • please approve/deny';
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