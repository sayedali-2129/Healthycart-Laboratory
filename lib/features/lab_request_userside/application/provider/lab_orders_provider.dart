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
  final rejectionFormKey = GlobalKey<FormState>();

  List<LabOrdersModel> newOrderList = [];
  List<LabOrdersModel> onProcessOrderList = [];
  List<LabOrdersModel> rejectedOrderList = [];

  final deliveryChargeController = TextEditingController();
  final rejectionController = TextEditingController();
  bool isLoading = false;

  // num doorStepCharge;

  // void setDoorStepCharge() {
  //   doorStepCharge = num.tryParse(deliveryChargeController.text)!;
  //   notifyListeners();
  // }

/* ------------------------------ FETCH ORDERS ------------------------------ */
  void getNewOrders({required String labId}) {
    ilabOrdersFacade.getLabOrders(labId: labId).listen((event) {
      event.fold(
        (err) {
          CustomToast.errorToast(text: err.errMsg);
        },
        (newOrders) {
          newOrderList = newOrders;
          notifyListeners();
        },
      );
    });

    notifyListeners();
  }

  /* -------------------------- GET ON PROCESS ORDERS ------------------------- */
  void getOnProcessOrders({required String labId}) {
    isLoading = true;
    notifyListeners();
    ilabOrdersFacade.getOnProcessOrders(labId: labId).listen((event) {
      event.fold(
        (err) {
          CustomToast.errorToast(text: err.errMsg);
          isLoading = false;
          notifyListeners();
        },
        (onProcessOrders) {
          onProcessOrderList = onProcessOrders;
          log(onProcessOrderList.length.toString());
          isLoading = false;
          notifyListeners();
        },
      );
    });
  }

  /* --------------------------- GET REJECTED ORDERS -------------------------- */
  Future<void> getRejectedOrders({required String labId}) async {
    isLoading = true;
    notifyListeners();
    final result = await ilabOrdersFacade.getRejectedOrders(labId: labId);
    result.fold(
      (err) {
        log('Error in getRejectedOrders() :: ${err.errMsg}');
      },
      (rejectedOrders) {
        rejectedOrderList = rejectedOrders;
      },
    );
    isLoading = false;
    notifyListeners();
  }

/* ---------------------------- UPDATE ORDER STATUS ---------------------------- */
  Future<void> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      num? finalAmount,
      num? currentAmount,
      String? rejectionReason}) async {
    isLoading = true;
    notifyListeners();
    final result = await ilabOrdersFacade.updateOrderStatus(
        finalAmount: finalAmount,
        orderId: orderId,
        orderStatus: orderStatus,
        currentAmount: currentAmount,
        rejectionReason: rejectionReason);
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
      isLoading = false;
      notifyListeners();
    }, (success) {
      CustomToast.sucessToast(text: success);
      isLoading = false;
      notifyListeners();
    });
  }

  /* --------------------------- SET DOORSTEP CHARGE -------------------------- */
  Future<void> updateDoorStepCharge({
    required String orderId,
    required num? charge,
  }) async {
    final order = newOrderList.firstWhere((order) => order.id == orderId);
    final totalAmount = order.totalAmount;

    // Calculate the final amount
    final finalAmount = totalAmount! + charge!;

    // Update the Firestore document
    final result = await ilabOrdersFacade.setDeliveryCharge(
      orderId: orderId,
      charge: charge,
      finalAmount: finalAmount,
    );
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        newOrderList = newOrderList.map((order) {
          if (order.id == orderId) {
            return order.copyWith(doorStepCharge: charge);
          }
          return order;
        }).toList();

        CustomToast.sucessToast(text: success);
        notifyListeners();
        CustomToast.sucessToast(text: success);
      },
    );
    notifyListeners();
  }

  num finalAmount(num doorStepCharge, num totalAmount) {
    return totalAmount + doorStepCharge;
  }
}
