// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:healthycart/core/custom/toast/toast.dart';
// import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
// import 'package:healthycart/features/home/domain/i_main_facade.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class HomeProvider extends ChangeNotifier {
//   HomeProvider(this._iHomeFacade);
//   final IHomeFacade _iHomeFacade;
//   HospitalModel? hospitalDetails;
//   String? userId;
//   Future<void> getHospitalDetails() async {
//     log('Main page getting userId $userId');
//     if (hospitalDetails != null) return;
//     final result = await _iHomeFacade.getHospitalDetails(userId: userId!);
//     result.fold((failure) {
//       log(failure.errMsg);
//       CustomToast.errorToast(text: "Couldn't able to get user");
//     }, (hospitaldetails) {
//       hospitalDetails = hospitaldetails;
//       log(hospitaldetails.address.toString());
//       notifyListeners();
//     });
//   }
// }
