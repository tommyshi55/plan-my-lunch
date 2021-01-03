import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/main/components/body.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('PLAN MY LUNCH'),
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}
