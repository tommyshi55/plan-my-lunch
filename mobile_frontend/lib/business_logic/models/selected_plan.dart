import 'package:flutter/foundation.dart';
import 'package:mobile_frontend/business_logic/models/selection.dart';

class SelectedPlan extends ChangeNotifier {
  Selection selectedPlan = Selection.none;

  void updateSelectedPlan(Selection selection) {
    selectedPlan = selection;
    notifyListeners();
  }
}
