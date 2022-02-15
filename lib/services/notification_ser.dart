// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   Future<void> init() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ab');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid, iOS: null, macOS: null);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: null);
//     //       NotificationDetails platformChannelSpecifics =
//     // NotificationDetails(android: androidPlatformChannelSpecifics);

//     //     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     //   AndroidNotificationDetails(
//     //       channelId: String,   //Required for Android 8.0 or after
//     //       channelName: String, //Required for Android 8.0 or after
//     //       channelDescription: String, //Required for Android 8.0 or after
//     //       importance: Importance,
//     //       priority: Priority,
//     //   );
//     // }

//     Future selectNotification(String payload) async {
//       //Handle notification tapped logic here
//     }
//   }
// }
