import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color, textColor;
  final double width;
  final double verticalMargin;

  const RoundedButton({
    Key key,
    this.text,
    this.onPressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.width,
    this.verticalMargin = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      width: width == null ? size.width * 0.8 : width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: FlatButton(
          color: color,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
