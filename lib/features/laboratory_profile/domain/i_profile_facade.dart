import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';

abstract class IProfileFacade {
  FutureResult<List<TestModel>> getTests();

  FutureResult<String> setActiveLaboratory(
      {required bool isLabON, required String labId});
}
