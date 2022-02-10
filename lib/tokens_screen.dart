import 'package:challenge_in_session/model/general_user.dart';
import 'package:challenge_in_session/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TokensScreen extends StatefulWidget {
  const TokensScreen({Key? key}) : super(key: key);

  @override
  _TokensScreenState createState() => _TokensScreenState();
}

class _TokensScreenState extends State<TokensScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String? usersToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
    getUsers();
  }

  Stream<List<GeneralUser>>? getUsers() {
    return _firestore.collection('users').snapshots().map(
          (docValue) => docValue.docs
              .map(
                (e) => GeneralUser.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      String? userUid =
          Provider.of<AuthService>(context, listen: false).user!.uid;
      GeneralUser theGeneralUser = GeneralUser(uid: userUid, tokens: [token!]);
      _firestore.collection('users').add(theGeneralUser.toMap());
      print(token);
    });

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: StreamBuilder<List<GeneralUser>>(
          stream: getUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return tokenCard(snapshot.data![index]);
                  });
            }
          }),
    );
  }

  Widget tokenCard(GeneralUser theUser) {
    return Card(
      child: Column(
        children: [
          Text('the uid: ' + theUser.uid),
          SizedBox(
            height: 30,
          ),
          Text('the token: ' + theUser.tokens.first),
        ],
      ),
    );
  }
}
