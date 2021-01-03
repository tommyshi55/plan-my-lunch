import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/views/constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function onPressed;

  const SocialIcon({
    Key key,
    this.iconSrc,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20.0,
          width: 20.0,
        ),
      ),
    );
  }
}
