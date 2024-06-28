import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/domain/i_profile_facade.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/domain/models/transfer_transaction_model.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this.iProfileFacade);
  final IProfileFacade iProfileFacade;
  final labId = FirebaseAuth.instance.currentUser?.uid;
  List<TestModel> testList = [];
  bool isLabOn = false;
  bool fetchLoading = false;

  void labStatus(bool status) {
    isLabOn = status;
    notifyListeners();
  }

  Future<void> getTests() async {
    final result = await iProfileFacade.getTests();
    result.fold((failure) {
      CustomToast.errorToast(
          text: "Couldn't able to get all laboratory details");
    }, (doctorData) {
      testList = doctorData;
    });
  }

  Future<void> setActiveLaboratory() async {
    final result = await iProfileFacade.setActiveLaboratory(
        isLabON: isLabOn, labId: labId ?? '');
    result.fold((failure) {
      CustomToast.errorToast(text: "Couldn't able to update Laboratory state");
    }, (sucess) {
      CustomToast.sucessToast(text: sucess);
    });
    notifyListeners();
  }

  List<TransferTransactionsModel> adminTransactionList = [];
  Future<void> getAdminTransactions({required String labId}) async {
    fetchLoading = true;
    notifyListeners();
    final result = await iProfileFacade.getAdminTransactionList(labId: labId);
    result.fold((err) {
      log('ERROR :;  ${err.errMsg}');
    }, (succes) {
      adminTransactionList.addAll(succes);
    });
    fetchLoading = false;
    notifyListeners();
  }

  void transactionInit(
      {required ScrollController scrollController, required String labId}) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0 &&
            fetchLoading == false) {
          getAdminTransactions(labId: labId);
        }
      },
    );
  }

  void clearTransactionData() {
    iProfileFacade.clearTransactionData();
    adminTransactionList = [];
    notifyListeners();
  }
}
