import 'package:mobile_frontend/business_logic/models/restaurant.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';

class SelectedPlan {
  Selection planType = Selection.none;
  Restaurant selectedRestaurant;

  SelectedPlan({this.planType, this.selectedRestaurant});
}
