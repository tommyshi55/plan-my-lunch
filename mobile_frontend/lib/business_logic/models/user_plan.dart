import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/business_logic/utils/util.dart';

import 'restaurant.dart';
import 'selected_plan.dart';
import 'selection.dart';

class UserPlan extends ChangeNotifier {
  Map<DateTime, SelectedPlan> cachedPlan = {};

  Future updatePlan(DateTime date, User user, SelectedPlan planToUpdate) async {
    String planType = "none";
    if (planToUpdate.planType == Selection.restaurant) {
      planType = "restaurant";
    } else if (planToUpdate.planType == Selection.leftover) {
      planType = "leftover";
    }

    print(user.uid);
    Map<String, dynamic> body = {
      "id": user.uid,
      "planType": planType,
      "date": convertDateTimeDisplay(date)
    };
    if (planType == "restaurant") {
      body['planDetail'] =
          json.encode(planToUpdate.selectedRestaurant.toJson());
    }

    var uri =
        Uri.https("us-central1-balmy-mark-301202.cloudfunctions.net", "plans");

    var response = await http.post(uri, body: body);
    final responseJson = jsonDecode(response.body);
    if (!responseJson["success"]) {
      throw Exception("Error updating plan");
    }

    cachedPlan[date] = planToUpdate;

    notifyListeners();
  }

  Future<SelectedPlan> getPlan(DateTime date, User user) async {
    if (cachedPlan.containsKey(date)) {
      return cachedPlan[date];
    }

    // get plan from database via http
    var queries = {"email": user.email, "date": convertDateTimeDisplay(date)};
    var uri = Uri.https(
        "us-central1-balmy-mark-301202.cloudfunctions.net", "plans", queries);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${user.uid}",
    });

    final responseJson = jsonDecode(response.body);
    Selection planType = Selection.none;
    Restaurant restaurant;
    if (responseJson['planType'] == "restaurant") {
      planType = Selection.restaurant;
      var restaurantJson = jsonDecode(responseJson['planDetail']);
      restaurant = Restaurant.fromJson(restaurantJson);
    } else if (responseJson['planType'] == "leftover") {
      planType = Selection.leftover;
    }

    SelectedPlan selectedPlan =
        SelectedPlan(planType: planType, selectedRestaurant: restaurant);

    cachedPlan[date] = selectedPlan;
    return selectedPlan;
  }
}
