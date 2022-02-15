import 'dart:convert';

import 'package:challenge_in_session/particular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendNotifyScreen extends StatefulWidget {
  SendNotifyScreen({Key? key, required this.token}) : super(key: key);
  String token;

  @override
  SendNotifyScreenState createState() => SendNotifyScreenState();
}

class SendNotifyScreenState extends State<SendNotifyScreen> {
  var postUrl = "fcm.googleapis.com/fcm/send";

  static Future<void> sendNotification(
      String destinationToken, String enteredTitle, String enteredBody) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAuAgG_JI:APA91bH_EqdWyVDHKUz0VpS1CIvscmKqbHcMm-ZZb--0Iwdk3pT8PmZ2kUjUHp5JYwaSEoFbqj7rx50oGEFGMK9PU23dC5ShwCM-C1wSRPVXLKm_fKKwaDr38PrDaOt7nF-fEgUYfo9r'
        },
        body: jsonEncode({
          'notification': <String, dynamic>{
            'title': enteredTitle,
            'body': enteredBody,
            'sound': 'true'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'screen': '/particular',
          },
          'to': destinationToken
        }));
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: bodyController,
          ),
          ElevatedButton(
            onPressed: () async {
              sendNotification(
                  widget.token, titleController.text, bodyController.text);
            },
            child: Text('send'),
          ),
        ],
      )),
    );
  }
}
