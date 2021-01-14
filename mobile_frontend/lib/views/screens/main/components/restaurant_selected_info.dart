import 'package:flutter/material.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';

class RestaurantSelectedInfo extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantSelectedInfo({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Restaurant Selected'),
    );
  }
}
