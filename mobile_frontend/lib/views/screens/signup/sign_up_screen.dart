import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/screens/signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'sign_up_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
