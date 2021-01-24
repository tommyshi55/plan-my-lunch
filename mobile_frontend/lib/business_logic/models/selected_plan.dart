import 'package:flutter/foundation.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';

class SelectedPlan extends ChangeNotifier {
  Selection planType = Selection.none;
  Restaurant selectedRestaurant;

  SelectedPlan({this.planType, this.selectedRestaurant});

  void updateSelectedPlan(Selection selection, {Restaurant restaurant}) {
    planType = selection;
    if (selection == Selection.restaurant) {
      selectedRestaurant = restaurant;
    }
    notifyListeners();
  }
}
