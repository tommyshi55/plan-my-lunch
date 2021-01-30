import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/restaurant_card.dart';
import 'package:provider/provider.dart';

class RestaurantSelectedInfo extends StatelessWidget {
  final Restaurant restaurant;
  final DateTime date;
  final User user;

  const RestaurantSelectedInfo({Key key, this.restaurant, this.date, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
          restaurant: restaurant,
          isInSearchResult: false,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        RoundedButton(
          text: 'CANCEL AND EDIT THE PLAN',
          onPressed: () async {
            await Provider.of<UserPlan>(context, listen: false)
                .updatePlan(date, user, SelectedPlan(planType: Selection.none));
          },
        ),
      ],
    );
  }
}
