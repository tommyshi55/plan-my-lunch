import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantActionModal extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantActionModal({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
            text: 'Add to the plan',
            onPressed: () {},
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
