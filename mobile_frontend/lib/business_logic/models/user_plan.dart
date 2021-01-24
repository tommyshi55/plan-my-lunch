import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'restaurant.dart';
import 'selected_plan.dart';
import 'selection.dart';

class UserPlan extends ChangeNotifier {
  Map<DateTime, SelectedPlan> cachedPlan = {};

  void updatePlan(DateTime date, SelectedPlan planToUpdate) async {
    notifyListeners();
  }

  Future<SelectedPlan> getPlan(DateTime date, User user) async {
    if (cachedPlan.containsKey(date)) {
      return cachedPlan[date];
    }

    // get plan from database via http
    var queries = {"email": user.email};
    var uri = Uri.https(
        "us-central1-balmy-mark-301202.cloudfunctions.net", "plans", queries);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: "Basic ${user.uid}",
    });

    final responseJson = jsonDecode(response.body);
    Selection planType = Selection.none;
    Restaurant restaurant;
    if (responseJson['planType'] == "restaurant") {
      planType = Selection.restaurant;
    } else if (responseJson['planType'] == "leftover") {
      planType = Selection.leftover;
    }

    SelectedPlan selectedPlan =
        SelectedPlan(planType: planType, selectedRestaurant: restaurant);

    cachedPlan[date] = selectedPlan;
    return selectedPlan;
  }
}