import 'package:challenge_in_session/particular.dart';
import 'package:challenge_in_session/services/authService.dart';
import 'package:challenge_in_session/tokens_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/notification_ser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) => print('firebase succeedeed.'));

  // await NotificationService().init(); // <----

  runApp(MyApp());
}

// Future<void> method() async{
//   print('-----------------------------------done');
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
    if (message != null && message.data['screen'] == '/particular') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ParticularScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    someMethod();
  }

  someMethod() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      notificationListenerHandler(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(notificationListenerHandler);
  }

  notificationListenerHandler(RemoteMessage message) {
    String navigation = message.data['screen'];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParticularScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<AuthService>(context, listen: false)
                      .signInAnonymously();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TokensScreen()));
                },
                child: Text("login anonymously"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
