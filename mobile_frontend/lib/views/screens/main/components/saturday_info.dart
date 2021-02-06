import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/views/constants.dart';

class SaturdayInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/saturday-brunch.svg',
          height: size.height * 0.35,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          'It is a Saturday! Enjoy your weekend! Go out and have an amazing brunch with friends and family!',
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
