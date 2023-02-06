import * as functions from "firebase-functions";

import * as firebase from 'firebase-admin';
firebase.initializeApp();
const firestore = firebase.firestore();


// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

exports.sendNotificationToDevice = functions.https.onRequest(async (request, response: any) => {
    try {
        const mobileNumber = request.body.mobileNumber;let  fcmToken: string = '' ;
    let isReminderButtonPressed ;
    console.log("Hi i am notification ");
    console.log("Hi i am mobile number ", mobileNumber);
    await  firestore.collection("UsersData").doc(mobileNumber).get().then(snapshot => {
        console.log("inside document");

         fcmToken = snapshot?.data()?.FcmToken ?? "";
         isReminderButtonPressed  =  snapshot?.data()?.isReminderButtonPressed ?? false;
        console.log('fcm token ', fcmToken);
    });
    console.log('isReminderButtonPressed',isReminderButtonPressed);
    const reminderButtonStatus = isReminderButtonPressed ==  true ? "True" : "False";
    console.log('reminderButtonStatus', reminderButtonStatus);
    const payload = {
            notification: {
                title: "Maxsip",
                body: "You are not entrolled",
                isReminderButton: reminderButtonStatus,
                // icon: "ic_notification",

                click_action: "FLUTTER_NOTIFICATION_CLICK",
            }, data: {
                title: "Alert",
                body: "TransferOut",
                isReminderButton: reminderButtonStatus,
                click_action: "FLUTTER_NOTIFICATION_CLICK"
            },
        };

  await firebase.messaging().sendToDevice(fcmToken, payload).catch((error) => {
        console.log("Error sending message:", error);
        response.send("Error sending message:\n\n" + error);


      });;

      return response.status(200).json({
        success: true,
        message: "Notifications send "
    });
    } catch (error) {

        return response.status(500).json({
            success: false,
            message: error
        });
    }

    
        

});

// exports.scheduledFunctionCrontab = functions.pubsub.schedule('every 2 minutes')
//   .onRun( async (context) => {
//     try {
//         // const tokens : any = [];
//         const collection =   await firestore.collection(ServerStrings.noAccountActive).get();
//    const payload = {
//     notification: {
//         title: "Maxsip",
//         body: "Please insert your sim",
//         // icon: "ic_notification",
//
//         click_action: "FLUTTER_NOTIFICATION_CLICK",
//     }
// }
//
// const docs = collection.docs;
// // docs.forEach(doc=> {
// //     tokens.push(doc.)
// // })
// const fcmToken = docs[0].data().fcmToken;
// console.log('FCM TOKEN data ', fcmToken);
// if (fcmToken !== null) {
//     const messagingDevicesResponse =  await firebase.messaging().sendToDevice(fcmToken, payload).catch(function (error) {
//         console.log("Error sending message: ", error);
//      });
//     console.log('the notification data ', messagingDevicesResponse);
// }
//
// // for (let i = 0; i < docs.length; i++) {
// //     if ( docs[i].data()!== null){
// //         const  fcmToken = docs[i].data()?.fcmToken ?? "";
// //         console.log('FCM TOKEN data ', fcmToken);
// //         const messagingDevicesResponse = await firebase.messaging().sendToDevice(fcmToken, payload);
// //         console.log('the notification data ', messagingDevicesResponse);
// //   }
// //   await collection.docs.forEach(doc=>{
//
// //  }
// //    });
//
//    console.log('COLLECTION DOC LENGTH===============', collection.docs.length);
//
//
//     }
// // }
//
//     catch (error) {
//         console.log('ERRRRRRRRORRRRRRRR========', error);
//     }
//
//
// });
