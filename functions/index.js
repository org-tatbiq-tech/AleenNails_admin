const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
var path = require('path');

// Macros
const appointmentsCollection = "appointments";
const clientsCollection = "clients";
const settingCollection = "settings";
const profileDoc = "profile";


// Profile images handler - any new image loaded into storage
// There is no way currently to listen to files changes in specific directory
// For that, creating once master cloud function which will navigate to proper image handler
// Functions are responsible to update imagePath.

// Logo, Cover & Work place images handler
function profileImagesHandler(fileObject) {
    // File object is the same object got into cloud function
    const filePath = fileObject.name; // File path in the bucket.
    if (!filePath.startsWith('profile/')) {
        return;
    }

    // Check if file is after resizer extension
    if (!filePath.endsWith('_600x600.png')) {
        return;
    }

    // Understanding what image are we loading (logo/cover/workplace) according to metadata
    // Metadata is dictionary, expecting type key
    const imageMetadata = fileObject.metadata;
    const fileName = path.basename(filePath);

    // Preparing record update
    var fsPath = '';
    var value = fileName;
    const type = 'type';
    if (imageMetadata[type] == 'logo') {
        console.log('got logo image');
        fsPath = 'media.logoPath';
    } else if (imageMetadata[type] == 'cover') {
        console.log('got cover image');
        fsPath = 'media.coverPath';
    } else {
        console.log('got workplace image');
        fsPath = 'media.wp';
        value = {fileName: ''};
    }

    // Update record accordingly
    var profile = admin.firestore().collection(settingCollection).doc(profileDoc);
    var data = {};
    data[fsPath] = value;
    return profile.update(data);
}

// Services image handler
function servicesImagesHandler(fileObject) {
    // Do something
}

// Clients image handler
function clientsImagesHandler(fileObject) {
    // Do something
}

exports.imagesHandler = functions.storage.bucket().object().onFinalize(async (object) => {
    const filePath = object.name; // File path in the bucket.

    // Check if file is after resizer
    if (!filePath.endsWith('_600x600.png')) {
        // Updating only in case of resized image
        return;
    }

    // Exit if the image uploaded is not part of profile.
    if (filePath.startsWith('profile/')) {
        return profileImagesHandler(object);
    }
    if (filePath.startsWith('services/')) {
        return profileImagesHandler(object);
    }
    if (filePath.startsWith('clients/')) {
        return profileImagesHandler(object);
    }
});

// Creating new appointment function listener, one new appointment added, need to update client's appointment list

// No need for now
//exports.newAppointment = functions.firestore.
//    document('appointments/{appointmentId}').
//    onCreate((snap, context) => {
//
//        // Getting details of the new document
//        const appointmentId = context.params.appointmentId;
//        const newAppointmentData = snap.data();
//
//        const clientDocID = newAppointmentData.clientDocID;
//
//        const client = admin.firestore().collection(clientsCollection).doc(clientDocID);
//
//        return client.get().then(clientDoc => {
//            clientAppointments = clientDoc.data().appointments
//            let services = [];
//            for(const idx in newAppointmentData.services) {
//                services.push(newAppointmentData.services[idx].name);
//            }
//            clientAppointments[appointmentId] = {
//                id: appointmentId,
//                startTime: newAppointmentData.date,
//                endTime: newAppointmentData.endTime,
//                totalCost: newAppointmentData.totalCost,
//                services: services,
//                status: newAppointmentData.status,
//                }
//            return client.update({
//                       appointments: clientAppointments
//           });
//        })
//
//         // Setting notification content - must send package_id
////        const notificationContent = {
////            notification: {
////                title: title,
////                body: msg,
////                sound: 'default'
////            },
////            data: {
////                package_id: packageId
////            }
////        };
////
////        return admin.messaging().sendToDevice(store.data()["tokens"], notificationContent);
//
//    })

// Updating existing appointment status
//exports.updateAppointmentStatus = functions.firestore.
//    document('appointments/{any}').
//    onUpdate((change, context) => {
//
//        // Get the updated object representing the updated document
//        const newValue = change.after.data();
//        const appointmentId = change.after.id;
//
//        // Get the previous object before this updated document
//        const previousValue = change.before.data();
//
//        if (newValue.status == previousValue.status) {
//            return;
//        }
//        // status has changed, hence, change status in user
//        const clientDocID = newValue.clientDocID;
//        const client = admin.firestore().collection(clientsCollection).doc(clientDocID);
//
//        return client.get().then(clientDoc => {
//            clientAppointments = clientDoc.data().appointments;
//            clientAppointment = clientDoc.data().appointments[appointmentId];
//            clientAppointment['status'] = newValue.status;
//            clientAppointments[appointmentId] = clientAppointment;
//
//            return client.update({
//                       appointments: clientAppointments
//           });
//        })
//    })

