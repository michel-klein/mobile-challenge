import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/filter_gender.dart';

class StateGender with ChangeNotifier {
  FilterGender filterGender = FilterGender(true, true);

  FilterGender get stateGender => filterGender;

  void changeFilterGender(FilterGender newFilterGender) {
    filterGender = newFilterGender;
    notifyListeners();
  }
}
