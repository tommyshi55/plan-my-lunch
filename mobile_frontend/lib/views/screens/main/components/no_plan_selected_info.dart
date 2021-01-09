import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/search_restaurant_screen.dart';
import 'package:provider/provider.dart';

class NoPlanSelectedInfo extends StatelessWidget {
  const NoPlanSelectedInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/main-empty.svg',
          height: size.height * 0.3,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Text(
          "You don't have any lunch plan for this day.",
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
            Navigator.pushNamed(context, SearchRestaurantScreen.id);
          },
        ),
        RoundedButton(
          text: 'LEFTOVER FROM DINNER',
          color: kPrimaryLightColor,
          textColor: Colors.black,
          onPressed: () {
            Provider.of<SelectedPlan>(context, listen: false)
                .updateSelectedPlan(Selection.leftover);
          },
        ),
      ],
    );
  }
}
