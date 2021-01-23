import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/business_logic/models/restaurant.dart';

class RestaurantService {
  Future<List> searchRestaurants(double lat, double lon) async {
    var queries = {
      'lat': lat.toString(),
      'lon': lon.toString(),
    };
    var uri = Uri.https("us-central1-balmy-mark-301202.cloudfunctions.net",
        "searchRestaurants", queries);
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
  }
}
