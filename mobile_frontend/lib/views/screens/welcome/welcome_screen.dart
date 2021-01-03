import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/screens/welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
