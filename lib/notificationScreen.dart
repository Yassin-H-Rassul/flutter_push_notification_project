import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyScreen extends StatefulWidget {
  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;

  @override
  void initState() {
    tz.initializeTimeZones();

    var initializationSettingsAndroid = new AndroidInitializationSettings('ab');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Hello Everyone"),
              content: Text("$payload"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('app'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Notification with Default Sound"),
            onPressed: () {
              notificationDefaultSound();
            },
          ),
          RaisedButton(
            child: Text("Notification without Sound"),
            onPressed: () {
              notificationNoSound();
            },
          ),
          RaisedButton(
            child: Text("Notification with Custom Sound"),
            onPressed: () {
              notificationCustomSound();
            },
          ),
          RaisedButton(
            child: Text(
              "Scheduled",
            ),
            onPressed: () {
              notificationScheduled();
            },
          )
        ],
      )),
    );
  }

  Future notificationDefaultSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'Default Sound');
  }

  Future notificationNoSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'No Sound');
  }

  Future<void> notificationCustomSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'flutterfcm',
      'flutterfcm',
      sound: RawResourceAndroidNotificationSound('sm'),
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'Custom Sound');
  }

  Future<void> notificationScheduled() async {
    int hour = 17;
    var ogValue = hour;
    int minute = 30;
    int second = 30;

    var time = Time(hour, minute, second);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      importance: Importance.max,
      // sound: 'slow_spring_board',
      ledColor: Color(0xFF3EB16F),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterNotificationPlugin.zonedSchedule(
        100,
        'title',
        'body',
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 10),
        ),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);

    // await flutterNotificationPlugin.showDailyAtTime(
    //   4,
    //   'show daily title',
    //   'Daily notification shown',
    //   tz.TZDateTime.now(tz.local).add(
    //     Duration(seconds: 10),
    //   ),
    //   platformChannelSpecifics,
    //   payload: "Hello",
    // );

    print('Set at ' + time.minute.toString() + " +" + time.hour.toString());
  }
}
