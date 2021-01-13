import 'dart:io';

import 'package:mobile_frontend/business_logic/models/restaurant.dart';

class RestaurantService {
  Future<List> searchRestaurants() async {
    List<Restaurant> restaurants = [
      Restaurant("7005126", "Welcome Eatery", "Orion Building, 181 Grafton Road, Grafton, Auckland 1010", "Grafton", 3.9, 10, "https://b.zmtcdn.com/data/pictures/6/7005126/8705514d0e6f26043fea380a3bd1ef18.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"),
      Restaurant("7005126", "Welcome Eatery", "Orion Building, 181 Grafton Road, Grafton, Auckland 1010", "Grafton", 3.9, 10, "https://b.zmtcdn.com/data/pictures/6/7005126/8705514d0e6f26043fea380a3bd1ef18.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"),
      Restaurant("7005126", "Welcome Eatery", "Orion Building, 181 Grafton Road, Grafton, Auckland 1010", "Grafton", 3.9, 10, "https://b.zmtcdn.com/data/pictures/6/7005126/8705514d0e6f26043fea380a3bd1ef18.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"),

    ];

    sleep(Duration(seconds: 3));
    return restaurants;
  }
}