import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/domain/models/transfer_transaction_model.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';

abstract class IProfileFacade {
  FutureResult<List<TestModel>> getTests();

  FutureResult<String> setActiveLaboratory(
      {required bool isLabON, required String labId});
  FutureResult<List<TransferTransactionsModel>> getAdminTransactionList(
      {required String labId});
  void clearTransactionData();
}
