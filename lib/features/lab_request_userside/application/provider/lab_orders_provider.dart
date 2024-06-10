import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/facade/i_lab_orders_facade.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class LabOrdersProvider with ChangeNotifier {
  LabOrdersProvider(this.ilabOrdersFacade);
  final ILabOrdersFacade ilabOrdersFacade;

  final deliveryChargeKey = GlobalKey<FormState>();

  List<LabOrdersModel> newOrderList = [];

  final deliveryChargeController = TextEditingController();

  // num doorStepCharge;

  // void setDoorStepCharge() {
  //   doorStepCharge = num.tryParse(deliveryChargeController.text)!;
  //   notifyListeners();
  // }

/* ------------------------------ FETCH ORDERS ------------------------------ */
  Future<void> getNewOrders({required String labId}) async {
    final result = await ilabOrdersFacade.getLabOrders(labId: labId);
    result.fold((err) {
      log('Error in getNewOrders(): $err');
    }, (success) {
      newOrderList = success;
      log(newOrderList.length.toString());
    });
    notifyListeners();
  }

  /* --------------------------- SET DOORSTEP CHARGE -------------------------- */
  Future<void> updateDoorStepCharge({required String orderId}) async {
    final result = await ilabOrdersFacade.setDeliveryCharge(
        orderId: orderId, charge: num.tryParse(deliveryChargeController.text)!);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
      },
    );
    notifyListeners();
  }

  num finalAmount(num doorStepCharge, num totalAmount) {
    return totalAmount + doorStepCharge;
  }
}
