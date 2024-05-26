// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
// import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
// import 'package:healthy_cart_laboratory/core/general/typdef.dart';
// import 'package:healthy_cart_laboratory/features/hospital_doctor/domain/model/add_doctor_model.dart';
// import 'package:healthy_cart_laboratory/features/hospital_profile/domain/i_profile_facade.dart';
// import 'package:injectable/injectable.dart';

// @LazySingleton(as: IProfileFacade)
// class IProfileImpl implements IProfileFacade {
//   IProfileImpl(this._repo);
//   final FirebaseFirestore _repo;

//   @override
//   FutureResult<List<DoctorAddModel>> getAllDoctorDetails() async {
//     try {
//       final snapshot = await _repo
//           .collection(FirebaseCollections.doctors)
//           .orderBy('createdAt')
//           .get();
//       log(' Implementation of get doctor called  :::: ');
//       return right(snapshot.docs
//           .map((e) => DoctorAddModel.fromMap(e.data()).copyWith(id: e.id))
//           .toList());
//     } on FirebaseException catch (e) {
//       log(e.code);
//       log(e.message!);
//       return left(MainFailure.firebaseException(errMsg: e.message.toString()));
//     } catch (e) {
//       return left(MainFailure.generalException(errMsg: e.toString()));
//     }
//   }

//   @override
//   FutureResult<String> setActiveHospital({
//     required bool ishospitalActive,
//     required String hospitalId,
//   }) async {
//     try {
//       await _repo
//           .collection(FirebaseCollections.hospitals)
//           .doc(hospitalId)
//           .update({'isActive': ishospitalActive});
//       return right('Sucessfully updated');
//     } on FirebaseException catch (e) {
//       return left(MainFailure.firebaseException(errMsg: e.code));
//     } catch (e) {
//       return left(MainFailure.generalException(errMsg: e.toString()));
//     }
//   }
// }
