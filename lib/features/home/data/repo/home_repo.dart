// import 'package:firebase_database/firebase_database.dart';
//
// class HomeRepo {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//
//   Future<void> setupUserPresence(String userId) async {
//       final userStatusDatabaseRef = _database.child('users/$userId/online');
//       final lastSeenRef = _database.child('users/$userId/lastSeen');
//
//       // Reference to check if the user is connected
//       final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
//
//       connectedRef.onValue.listen((event) {
//         final connected = event.snapshot.value as bool;
//
//         if (connected) {
//           // User is online
//           userStatusDatabaseRef.set(true);
//           userStatusDatabaseRef
//               .onDisconnect()
//               .set(false); // Set offline on disconnect
//           lastSeenRef
//               .onDisconnect()
//               .set(ServerValue.timestamp); // Set last seen on disconnect
//         } else {
//           // User is offline
//           userStatusDatabaseRef.set(false);
//         }
//       });
//   }
// }
//StreamBuilder(
//         stream: FirebaseDatabase.instance.ref('users/${chat.chatPartnerId}/online').onValue,
//         builder: (context, snapshot) {
//           bool isOnline = snapshot.data!.snapshot.value as bool? ??false;
//           }
//         );