import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';

class ErrorInfo extends StatelessWidget {
  final Function reload;

  ErrorInfo({Key key, this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/error.svg',
          height: size.height * 0.35,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          'Oops something went wrong. Please check your network connection and try again.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        RoundedButton(
          text: 'TRY AGAIN',
          onPressed: reload,
        ),
      ],
    );
  }
}
