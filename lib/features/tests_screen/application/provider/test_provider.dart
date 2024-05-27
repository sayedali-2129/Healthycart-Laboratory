import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/facade/i_test_facade.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestProvider with ChangeNotifier {
  TestProvider(this.iTestFacade);
  final ITestFacade iTestFacade;

  File? imageFile;
  String? imageUrl;
  TestModel? testModel;
  bool isDoorStepAvailable = false;
  List<TestModel> testList = [];
  bool labFetchLoading = false;

  final testNameController = TextEditingController();
  final priceController = TextEditingController();
  final offerPriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void checkBox() {
    isDoorStepAvailable = !isDoorStepAvailable;
    notifyListeners();
  }

  Future<void> pickLabImage() async {
    final result = await iTestFacade.pickLabImage();
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        imageUrl = null;

        imageFile = success;
      },
    );
    notifyListeners();
  }

  Future<void> saveImage() async {
    final result = await iTestFacade.saveLabImage(imageFile: imageFile!);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        imageUrl = success;
      },
    );
    imageFile = null;

    notifyListeners();
  }

  void clearImages() {
    imageFile = null;
    imageUrl = null;
    notifyListeners();
  }

  void clearFields() {
    testNameController.clear();
    priceController.clear();
    offerPriceController.clear();
    notifyListeners();
  }

  Future<void> addNewTest({required String labId}) async {
    final testModelAdd = TestModel(
        createdAt: Timestamp.now(),
        labId: labId,
        offerPrice: num.tryParse(offerPriceController.text),
        testPrice: num.tryParse(priceController.text),
        testImage: imageUrl,
        testName: testNameController.text,
        isDoorstepAvailable: isDoorStepAvailable);

    final result = await iTestFacade.addNewTest(testModel: testModelAdd);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
        testList.insert(0, testModelAdd);

        clearImages();
        clearFields();
        isDoorStepAvailable = false;
      },
    );

    notifyListeners();
  }

  Future<void> getTests({required String labId}) async {
    labFetchLoading = true;
    notifyListeners();
    final result = await iTestFacade.getTests(labId: labId);
    result.fold(
      (err) {
        log('Error in Provider getTests() :: ${err.errMsg}');
      },
      (success) {
        testList = success;
      },
    );
    labFetchLoading = false;
    notifyListeners();
  }

  Future<void> deleteTest({required String testId, required int index}) async {
    final result = await iTestFacade.deleteTest(testId: testId);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
        testList.removeAt(index);
      },
    );
    notifyListeners();
  }

  Future<void> editTest(
      {required String testId,
      required TestModel testDetails,
      required int index}) async {
    final testModel = TestModel(
        labId: testDetails.labId,
        createdAt: testDetails.createdAt,
        offerPrice: num.tryParse(offerPriceController.text),
        testPrice: num.tryParse(priceController.text),
        testImage: imageUrl,
        testName: testNameController.text,
        isDoorstepAvailable: isDoorStepAvailable);

    final result =
        await iTestFacade.editTest(testId: testId, testModel: testModel);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
        testList.removeAt(index);
        testList.insert(index, testModel);
      },
    );
    notifyListeners();
  }

  void setEditData(TestModel editData) {
    testNameController.text = editData.testName!;
    imageUrl = editData.testImage;
    priceController.text = editData.testPrice.toString();
    isDoorStepAvailable = editData.isDoorstepAvailable!;
    offerPriceController.text = editData.offerPrice.toString();
    notifyListeners();
  }
}
