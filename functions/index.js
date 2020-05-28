const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotification = functions.firestore
  .document('chat/{message}')
  .onCreate((snap, context) => {
    return admin.messaging().sendToTopic('chat', {
      notification: {
        title: snap.data().username,
        body: snap.data().text,
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });
