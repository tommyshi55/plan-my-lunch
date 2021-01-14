import 'package:flutter/foundation.dart';
import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';

class SelectedPlan extends ChangeNotifier {
  Selection selectedPlan = Selection.none;
  Restaurant selectedRestaurant;

  void updateSelectedPlan(Selection selection, {Restaurant restaurant}) {
    selectedPlan = selection;
    if (selection == Selection.restaurant) {
      selectedRestaurant = restaurant;
    }
    notifyListeners();
  }
}
