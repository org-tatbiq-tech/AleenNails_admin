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
        let myAppointment = {
            appointmentId: { id: appointmentId}

        }
        return client.update({
                   appointments: myAppointment
       });
//        return client.get().then(clientDoc => {
//            clientDoc
//        }

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