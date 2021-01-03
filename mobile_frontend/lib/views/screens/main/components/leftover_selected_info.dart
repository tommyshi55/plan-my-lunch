import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:provider/provider.dart';

class LeftoverSelectedInfo extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/leftover.svg',
          height: size.height * 0.35,
        ),
        Text(
          'You are going to have the leftover from the night before. Remember to pack your lunch!',
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
          text: 'CANCEL AND EDIT THE PLAN',
          onPressed: () {
            Provider.of<SelectedPlan>(context, listen: false)
                .updateSelectedPlan(Selection.none);
          },
        ),
      ],
    );
  }
}