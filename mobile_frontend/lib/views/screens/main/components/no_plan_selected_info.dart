import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/components/user_and_date.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/search_restaurant_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class NoPlanSelectedInfo extends StatefulWidget {
  final DateTime date;
  final User user;

  const NoPlanSelectedInfo({
    Key key,
    this.date,
    this.user,
  }) : super(key: key);

  @override
  _NoPlanSelectedInfoState createState() => _NoPlanSelectedInfoState();
}

class _NoPlanSelectedInfoState extends State<NoPlanSelectedInfo> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      opacity: 0,
      inAsyncCall: loading,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/main-empty.svg',
            height: size.height * 0.3,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            "You don't have any lunch plan for this day. Make your plan now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            text: 'SEARCH RESTAURANT',
            onPressed: () {
              Navigator.pushNamed(context, SearchRestaurantScreen.id,
                  arguments: UserAndDate(widget.date, widget.user));
            },
          ),
          RoundedButton(
            text: 'LEFTOVER FROM DINNER',
            color: kPrimaryLightColor,
            textColor: Colors.black,
            onPressed: () async {
              try {
                setState(() {
                  loading = true;
                });
                await Provider.of<UserPlan>(context, listen: false).updatePlan(
                    widget.date,
                    widget.user,
                    SelectedPlan(planType: Selection.leftover));
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
