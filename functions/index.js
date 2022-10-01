const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Macros
const appointmentsCollection = "stores";
const clientsCollection = "stores";

// Creating new appointment function listener, one new appointment added, need to update client's appointment list

exports.newAppointment = functions.firestore.
    document('appointments/{appointmentId}').
    onCreate((snap, context) => {

        // Getting details of the new document
        const appointmentId = context.params.packageId;
        const newAppointmentData = snap.data();

        const clientDocID = newAppointmentData.clientDocID;
        const client = admin.firestore().collection(clientsCollection).doc(clientDocID);

    }
