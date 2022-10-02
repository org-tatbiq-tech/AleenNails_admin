const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Macros
const appointmentsCollection = "appointments";
const clientsCollection = "clients";

// Creating new appointment function listener, one new appointment added, need to update client's appointment list

exports.newAppointment = functions.firestore.
    document('appointments/{appointmentId}').
    onCreate((snap, context) => {

        // Getting details of the new document
        const appointmentId = context.params.appointmentId;
        const newAppointmentData = snap.data();

        const clientDocID = newAppointmentData.clientDocID;
        const client = admin.firestore().collection(clientsCollection).doc(clientDocID);

        return client.get().then(clientDoc => {
//            let myAppointment = {
//            }
//            myAppointment[appointmentId] = { id: appointmentId}
            clientAppointments = clientDoc.data().appointments
            clientAppointments[appointmentId] = { id: appointmentId}
            return client.update({
                       appointments: clientAppointments
           });
        })

         // Setting notification content - must send package_id
//        const notificationContent = {
//            notification: {
//                title: title,
//                body: msg,
//                sound: 'default'
//            },
//            data: {
//                package_id: packageId
//            }
//        };
//
//        return admin.messaging().sendToDevice(store.data()["tokens"], notificationContent);

    })