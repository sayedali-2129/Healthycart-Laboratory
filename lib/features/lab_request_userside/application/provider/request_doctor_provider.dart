import 'package:flutter/material.dart';


class RequestDoctorProvider extends ChangeNotifier{
  bool fetchloading = true;
  int tabIndex = 0;

    void changeTabINdex({required int index,}) {
    tabIndex = index;
    notifyListeners();
  }
}