const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.deleteExpiredStatuses = functions.pubsub.schedule("every 24 hours").onRun(async (context) => {
  const firestore = admin.firestore();
  const now = admin.firestore.Timestamp.now();
  const expiryTime = now.toDate();
  expiryTime.setHours(expiryTime.getHours() - 24);

  const usersSnapshot = await firestore.collection("users").get();

  const batch = firestore.batch();

  for (const userDoc of usersSnapshot.docs) {
    const userId = userDoc.id;

    const statusesRef = firestore.collection("users").doc(userId).collection("statuses");

    const expiredStatusesSnapshot = await statusesRef
        .where("timestamp", "<=", admin.firestore.Timestamp.fromDate(expiryTime))
        .get();

    expiredStatusesSnapshot.forEach((statusDoc) => {
      batch.delete(statusDoc.ref);
    });
  }

  return batch.commit().then(() => {
    console.log("Expired statuses deleted from all users");
  }).catch((error) => {
    console.error("Error deleting expired statuses:", error);
  });
});
