const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
var path = require('path');

// Macros
const appointmentsCollection = "appointments";
const clientsCollection = "clients";
const adminsCollection = "admins";

function isClient(editor) {
    return editor === 'AppointmentCreator.client';
}

function isBusiness(editor) {
    return editor === 'AppointmentCreator.business';
}

async function getClientTokens(clientDocID) {
    const clientResults  = await admin.firestore().collection(clientsCollection).doc(clientDocID).get();
    const client = clientResults.data();
    return client['tokens'];
}

async function getAdminTokens() {
    let adminTokens = [];
    const adminResults  = await admin.firestore().collection(adminsCollection).get();
    for (adminDoc of adminResults.docs) {
        const adminEmail = adminDoc.id;
        const adminClientResults = await admin.firestore().collection(clientsCollection).where('email', '==', adminEmail).get();
        for (adminClientDoc of adminClientResults.docs) {
            currentTokens = adminClientDoc.data()['tokens'];
            adminTokens = [...adminTokens, ...currentTokens]
        }
    }
    return adminTokens;
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
       const clientName = newAppointmentData.clientName ?? 'User';
       const title = clientName + ' Created new appointment';
       const services = newAppointmentData.services ? newAppointmentData.services.length : 0;
       const msg = clientName + ' created new appointment for ' +  services + ' services'
       // Setting notification content - must send package_id
       const notificationContent = {
           notification: {
               title: title,
               body: msg,
               sound: 'default'
           },
           data: {
               client_id: clientDocID,
               appointment_id: appointmentId,
               category: 'NotificationCategory.appointment',
           }
       };
       const adminTokens = await getAdminTokens();
       return admin.messaging().sendToDevice(adminTokens, notificationContent);
    }
    if ( isBusiness(newAppointmentData.creator) ) {
        console.log('Appointment created by business. need to notify the client');
        const clientTokens = await getClientTokens(clientDocID);
        if(clientTokens) {
             const title = 'Aleen Created new appointment for you';
             const services = newAppointmentData.services ? newAppointmentData.services.length : 0;
             const msg = 'New appointment with ' +  services + ' services'
             const notificationContent = {
                notification: {
                  title: title,
                  body: msg,
                  sound: 'default'
                },
                data: {
                  client_id: clientDocID,
                  appointment_id: appointmentId,
                  category: 'NotificationCategory.appointment',
                }
            };
            console.log('Sending notification to ', newAppointmentData.clientName)
            admin.messaging().sendToDevice(clientTokens, notificationContent);
        }
    }
}

async function handleAppointmentUpdate(change, context) {
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
        let title = changedByClient ? newValue.clientName : 'Aleen';
        title += ' rescheduled the appointment';
        const msg = 'Appointment moved to ' + newValue.date.toDate();
        const notificationContent = {
            notification: {
              title: title,
              body: msg,
              sound: 'default'
            },
            data: {
              client_id: clientDocID,
              appointment_id: appointmentId,
              category: 'NotificationCategory.appointment',
            }
        };
        console.log('Send notification about the rescheduled appointment')
        if (changedByClient) {
            const adminTokens = await getAdminTokens();
            return admin.messaging().sendToDevice(adminTokens, notificationContent);
        } else {
            const clientTokens = await getClientTokens(clientDocID);
            if(clientTokens) {
                console.log('Sending notification to ', newValue.clientName)
                return admin.messaging().sendToDevice(clientTokens, notificationContent);
            }
        }
    }
    if (newValue.status != previousValue.status) {
        if(newValue.status === 'AppointmentStatus.confirmed') {
            console.log('Send notification about confirmed appointment')
            const title = 'Aleen confirmed your appointment';
            const msg = 'We are expecting you on ' + newValue.date.toDate();
            const notificationContent = {
               notification: {
                 title: title,
                 body: msg,
                 sound: 'default'
               },
               data: {
                 client_id: clientDocID,
                 appointment_id: appointmentId,
                 category: 'NotificationCategory.appointment',
               }
           };
           const clientTokens = await getClientTokens(clientDocID);
           if(clientTokens) {
               console.log('Sending notification to ', newValue.clientName)
               return admin.messaging().sendToDevice(clientTokens, notificationContent);
           }
        }
        if(newValue.status === 'AppointmentStatus.declined') {
            console.log('Send notification about declined appointment')
            const title = 'Failed to schedule your appointment';
            const msg = 'Please contact Aleen to schedule the appointment';
            const notificationContent = {
               notification: {
                 title: title,
                 body: msg,
                 sound: 'default'
               },
               data: {
                 client_id: clientDocID,
                 appointment_id: appointmentId,
                 category: 'NotificationCategory.appointment',
               }
           };
           const clientTokens = await getClientTokens(clientDocID);
           if(clientTokens) {
               console.log('Sending notification to ', newValue.clientName)
               return admin.messaging().sendToDevice(clientTokens, notificationContent);
           }
        }

        if(newValue.status ==='AppointmentStatus.cancelled') {
            console.log('Notify that appointment is cancelled');
            let title = changedByClient ? newValue.clientName : 'Aleen';
            title += ' canceled the appointment';
            const msg = 'Appointment on ' + newValue.date.toDate() + 'is canceled';
            const notificationContent = {
                notification: {
                  title: title,
                  body: msg,
                  sound: 'default'
                },
                data: {
                  client_id: clientDocID,
                  appointment_id: appointmentId,
                  category: 'NotificationCategory.appointment',
                }
            };
            console.log('Send notification about the canceled appointment')
            if (changedByClient) {
                const adminTokens = await getAdminTokens();
                return admin.messaging().sendToDevice(adminTokens, notificationContent);
            } else {
                const clientTokens = await getClientTokens(clientDocID);
                if(clientTokens) {
                    console.log('Sending notification to ', newValue.clientName)
                    return admin.messaging().sendToDevice(clientTokens, notificationContent);
                }
            }
        }
    }
}


// Handle new appointment
exports.newAppointment = functions.firestore.
    document('appointments/{appointmentId}').
    onCreate(handleNewAppointment);


// Handle updating appointment
exports.updateAppointment = functions.firestore.
    document('appointments/{any}').
    onUpdate(handleAppointmentUpdate);
