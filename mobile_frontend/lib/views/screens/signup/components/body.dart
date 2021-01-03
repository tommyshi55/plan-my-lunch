import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/views/components/already_have_an_account_check.dart';
import 'package:mobile_frontend/views/components/background.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/components/rounded_input_field.dart';
import 'package:mobile_frontend/views/components/rounded_password_field.dart';
import 'package:mobile_frontend/views/screens/login/login_screen.dart';
import 'package:mobile_frontend/views/screens/signup/components/or_divider.dart';
import 'package:mobile_frontend/views/screens/signup/components/social_icon.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SIGN UP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            'assets/icons/signup.svg',
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: 'Your Email',
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: 'SIGN UP',
            onPressed: () {},
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(
                iconSrc: 'assets/icons/facebook.svg',
                onPressed: () {},
              ),
              SocialIcon(
                iconSrc: 'assets/icons/google-plus.svg',
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
