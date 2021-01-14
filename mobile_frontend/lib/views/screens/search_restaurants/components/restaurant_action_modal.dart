import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantActionModal extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantActionModal({
    Key key,
    this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
            text: 'Add to the plan',
            onPressed: () {
              Provider.of<SelectedPlan>(context, listen: false)
                  .updateSelectedPlan(Selection.restaurant,
                      restaurant: restaurant);
              Navigator.popUntil(context, ModalRoute.withName(MainScreen.id));
            },
          ),
          RoundedButton(
            text: 'Open in Zomato',
            onPressed: () async {
              String url = restaurant.url;
              if (await canLaunch(url)) {
                print('Ready to launch');
                await launch(url);
              } else {
                // TODO: Display error message
                print('cannot launch');
              }
            },
          ),
          RoundedButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
            textColor: Colors.black,
            color: kPrimaryLightColor,
          ),
        ],
      ),
    );
  }
}
