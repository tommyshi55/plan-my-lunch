import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/business_logic/models/restaurant.dart';

class RestaurantService {
  Future<List> searchRestaurants(double lat, double lon) async {
    var queries = {
      'lat': lat.toString(),
      'lon': lon.toString(),
    };
    var uri = Uri.http("localhost:5001",
        "balmy-mark-301202/us-central1/searchRestaurants", queries);
    var response = await http.get(uri);

    List<Restaurant> restaurants = [];
    if (response.statusCode == 200) {
      var restaurantData = jsonDecode(response.body)['restaurants'];
      for (var restaurantJson in restaurantData) {
        var restaurantInfo = restaurantJson['restaurant'];
        restaurants.add(Restaurant(
          restaurantInfo['id'],
          restaurantInfo['name'],
          restaurantInfo['location']['address'],
          restaurantInfo['location']['locality'],
          restaurantInfo['user_rating']['aggregate_rating']?.toString(),
          restaurantInfo['all_reviews_count'],
          restaurantInfo['featured_image'] ?? restaurantInfo['thumb'],
          restaurantInfo['url'],
        ));
      }
      return restaurants;
    } else {
      throw Exception('Error retrieving restaurants');
    }

    // int randNum = Random().nextInt(10) + 1;
    //
    // for (int i = 0; i < randNum; i++) {
    //   restaurants.add(Restaurant(
    //       "7005126",
    //       "Welcome Eatery",
    //       "Orion Building, 181 Grafton Road, Grafton, Auckland 1010",
    //       "Grafton",
    //       "3.9",
    //       "10",
    //       "https://b.zmtcdn.com/data/pictures/6/7005126/8705514d0e6f26043fea380a3bd1ef18.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
    //       "https://www.zomato.com/auckland/welcome-eatery-grafton?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1"));
    // }
    //
    // sleep(Duration(seconds: 1));
    return restaurants;
  }
}
