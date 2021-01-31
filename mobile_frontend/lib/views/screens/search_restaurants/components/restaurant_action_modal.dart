import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selected_plan.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/main/main_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantActionModal extends StatefulWidget {
  final Restaurant restaurant;
  final bool displayAddButton;
  final User user;
  final DateTime date;

  RestaurantActionModal({
    Key key,
    this.restaurant,
    this.displayAddButton,
    this.user,
    this.date,
  }) : super(key: key);

  @override
  _RestaurantActionModalState createState() => _RestaurantActionModalState();
}

class _RestaurantActionModalState extends State<RestaurantActionModal> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.displayAddButton
                ? RoundedButton(
                    text: 'Add to the plan',
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });

                        SelectedPlan selectedPlan = SelectedPlan(
                          planType: Selection.restaurant,
                          selectedRestaurant: widget.restaurant,
                        );

                        await Provider.of<UserPlan>(context, listen: false)
                            .updatePlan(widget.date, widget.user, selectedPlan);

                        Navigator.popUntil(
                            context, ModalRoute.withName(MainScreen.id));
                      } catch (e) {
                        print(e);
                        // TODO: Display error
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            RoundedButton(
              text: 'Open in Zomato',
              onPressed: () async {
                String url = widget.restaurant.url;
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
      ),
    );
  }
}
