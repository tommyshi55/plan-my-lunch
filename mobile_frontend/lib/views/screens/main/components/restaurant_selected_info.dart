import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/restaurant_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RestaurantSelectedInfo extends StatefulWidget {
  final Restaurant restaurant;
  final DateTime date;
  final User user;

  const RestaurantSelectedInfo({Key key, this.restaurant, this.date, this.user})
      : super(key: key);

  @override
  _RestaurantSelectedInfoState createState() => _RestaurantSelectedInfoState();
}

class _RestaurantSelectedInfoState extends State<RestaurantSelectedInfo> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hooray! On this day, you are going to:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RestaurantCard(
            restaurant: widget.restaurant,
            isInSearchResult: false,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            text: 'CANCEL AND EDIT THE PLAN',
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await Provider.of<UserPlan>(context, listen: false).updatePlan(
                  widget.date,
                  widget.user,
                  SelectedPlan(planType: Selection.none));
              setState(() {
                loading = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
