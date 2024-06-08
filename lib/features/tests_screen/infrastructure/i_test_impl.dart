import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/core/services/image_picker.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/facade/i_test_facade.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITestFacade)
class ITestImpl implements ITestFacade {
  ITestImpl(this._firestore, this._imageService);
  final FirebaseFirestore _firestore;
  final ImageService _imageService;

  @override
  FutureResult<File> pickLabImage() async {
    return await _imageService.getGalleryImage();
  }

  @override
  FutureResult<String> saveLabImage({required File imageFile}) async {
    return await _imageService.saveImage(
        folderName: 'lab_tests', imageFile: imageFile);
  }

  @override
  FutureResult<String> addNewTest({required TestModel testModel}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.laboratoryTests)
          .add(testModel.toMap());
      return right('New Test Added Successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<List<TestModel>> getTests({required String labId}) async {
    try {
      final responce = await _firestore
          .collection(FirebaseCollections.laboratoryTests)
          .orderBy('createdAt', descending: true)
          .where('labId', isEqualTo: labId)
          .get();
      final testList = responce.docs
          .map((e) => TestModel.fromMap(e.data()).copyWith(id: e.id))
          .toList();
      return right(testList);
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<String> deleteTest({required String testId}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.laboratoryTests)
          .doc(testId)
          .delete();

      return right('Test Deleted Successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<TestModel> editTest(
      {required String testId, required TestModel testModel}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.laboratoryTests)
          .doc(testId)
          .update(testModel.toMap());
      return right(testModel.copyWith(id: testId));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
