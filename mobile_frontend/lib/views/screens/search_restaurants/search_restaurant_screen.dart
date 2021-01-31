import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/components/user_and_date.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/body.dart';

class SearchRestaurantScreen extends StatelessWidget {
  static const String id = 'search_restaurant_screen';

  @override
  Widget build(BuildContext context) {
    final UserAndDate args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Search'),
      ),
      body: Body(
        user: args.user,
        date: args.date,
      ),
    );
  }
}
