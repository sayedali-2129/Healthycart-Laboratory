// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:healthycart/core/failures/main_failure.dart';
// import 'package:healthycart/core/general/firebase_collection.dart';
// import 'package:healthycart/features/add_hospital_form/domain/model/hospital_model.dart';
// import 'package:healthycart/features/home/domain/i_main_facade.dart';
// import 'package:injectable/injectable.dart';

// @LazySingleton(as: IHomeFacade)
// class IHomeImpl implements IHomeFacade {
//   IHomeImpl(this._repo, );
//     final FirebaseFirestore _repo;
//   @override
//   Future<Either<MainFailure, HospitalModel>> getHospitalDetails(
//       {required String userId}) async {
//     try {
//       final snapshot = await _repo.collection(FirebaseCollections.hospitals).doc(userId).get();
//       return right(HospitalModel.fromMap(snapshot.data()!));
//     } on FirebaseException catch (e) {
//       return left(MainFailure.firebaseException(errMsg: e.message.toString()));
//     } catch (e) {
//       return left(MainFailure.firebaseException(errMsg: e.toString()));
//     }
//   }
// }
