import 'package:flutter/material.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/components/body.dart';

class SearchRestaurantScreen extends StatelessWidget {
  static const String id = 'search_restaurant_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Search'),
      ),
      body: Body(),
    );
  }
}
