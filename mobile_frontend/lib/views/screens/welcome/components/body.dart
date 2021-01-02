import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WELCOME TO PLAN MY LUNCH',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SvgPicture.asset(
            'assets/icons/welcome.svg',
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          RoundedButton(
            text: 'LOGIN',
            onPressed: () {},
          ),
          RoundedButton(
            text: 'SIGNUP',
            color: kPrimaryLightColor,
            textColor: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
