// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/domain/i_profile_facade.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class ProfileProvider extends ChangeNotifier {
//   ProfileProvider(this.iProfileFacade);
//   final IProfileFacade iProfileFacade;
//   final hospitalId = FirebaseAuth.instance.currentUser?.uid;
//   List<DoctorAddModel> doctorTotalList = [];

//   Future<void> getAllDoctorDetails() async {
//     final result = await iProfileFacade.getAllDoctorDetails();
//     result.fold((failure) {
//       CustomToast.errorToast(text: "Couldn't able to get all doctor details");
//     }, (doctorData) {
//       doctorTotalList = doctorData;
//     });
//   }

//   Future<void> setActiveHospital({
//     required bool ishospitalActive,
//   }) async {
//     final result = await iProfileFacade.setActiveHospital(
//         ishospitalActive: ishospitalActive, hospitalId: hospitalId ?? '');
//     result.fold((failure) {
//       CustomToast.errorToast(text: "Couldn't able to update hospital state");
//     }, (sucess) {
//       CustomToast.sucessToast(text: sucess);
//     });
//     notifyListeners();
//   }
// }
