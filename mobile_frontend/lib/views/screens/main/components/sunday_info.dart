import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/views/constants.dart';

class SundayInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/sunday.svg',
          height: size.height * 0.35,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          'It is a Sunday! Enjoy the last day of the weekend. Remember to start planning your lunch for next week!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            height: 2,
          ),
        ),
      ],
    );
  }
}
