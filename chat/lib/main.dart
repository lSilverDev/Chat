import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseFirestore Firestore = FirebaseFirestore.instance;
  Firestore.collection("tests").doc().set({"deu bom?": true, "DateTime": DateTime.now().toString()});

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Deus
  await Firebase.initializeApp(); //Brasil
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore Firestore = FirebaseFirestore.instance;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Firestore.collection("users").doc("blblbl").set({"fcm": fcmToken});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
