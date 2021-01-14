import 'dart:io';
import 'dart:math';

import 'package:mobile_frontend/business_logic/models/restaurant.dart';

class RestaurantService {
  Future<List> searchRestaurants() async {
    int randNum = Random().nextInt(10) + 1;
    List<Restaurant> restaurants = [];

    for (int i = 0; i < randNum; i++) {
      restaurants.add(Restaurant(
          "7005126",
          "Welcome Eatery",
          "Orion Building, 181 Grafton Road, Grafton, Auckland 1010",
          "Grafton",
          3.9,
          10,
          "https://b.zmtcdn.com/data/pictures/6/7005126/8705514d0e6f26043fea380a3bd1ef18.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
          "https://www.zomato.com/auckland/welcome-eatery-grafton?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1"));
    }

    sleep(Duration(seconds: 2));
    return restaurants;
  }
}
