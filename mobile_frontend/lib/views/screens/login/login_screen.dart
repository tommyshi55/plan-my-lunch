import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/screens/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
