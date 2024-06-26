import 'dart:io';

import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';

abstract class ITestFacade {
  FutureResult<File> pickLabImage();
  FutureResult<String> saveLabImage({required File imageFile});
  FutureResult<TestModel> addNewTest({required TestModel testModel});
  FutureResult<List<TestModel>> getTests({required String labId});
  FutureResult<String> deleteTest({required String testId});
  FutureResult<TestModel> editTest(
      {required String testId, required TestModel testModel});
}
