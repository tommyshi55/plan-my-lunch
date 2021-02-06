import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

const String textIfAlreadyPassed =
    "On this day, you had the leftover from the night before. Wish it was still delicious!";
const String textForFuture =
    "You are going to have the leftover from the night before. Remember to pack your lunch!";

class LeftoverSelectedInfo extends StatefulWidget {
  final DateTime date;
  final User user;
  final bool isDatePassed;

  LeftoverSelectedInfo({
    Key key,
    this.date,
    this.user,
    this.isDatePassed,
  }) : super(key: key);

  @override
  _LeftoverSelectedInfoState createState() => _LeftoverSelectedInfoState();
}

class _LeftoverSelectedInfoState extends State<LeftoverSelectedInfo> {
  bool loading = false;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/leftover.svg',
            height: size.height * 0.35,
          ),
          Text(
            widget.isDatePassed ? textIfAlreadyPassed : textForFuture,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          widget.isDatePassed
              ? Container()
              : RoundedButton(
                  text: 'CANCEL AND EDIT THE PLAN',
                  onPressed: () async {
                    try {
                      setState(() {
                        loading = true;
                      });
                      await Provider.of<UserPlan>(context, listen: false)
                          .updatePlan(widget.date, widget.user,
                              SelectedPlan(planType: Selection.none));
                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
        ],
      ),
    );
  }
}
