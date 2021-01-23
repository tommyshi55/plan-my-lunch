import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/main/components/body.dart';

import '../welcome/welcome_screen.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('PLAN MY LUNCH'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            _auth.signOut();
            Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
          },
        ),
      ),
      body: Body(),
    );
  }
}
