import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/facade/i_lab_orders_facade.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class LabOrdersProvider with ChangeNotifier {
  LabOrdersProvider(this.ilabOrdersFacade);
  final ILabOrdersFacade ilabOrdersFacade;

  final deliveryChargeKey = GlobalKey<FormState>();
  final rejectionFormKey = GlobalKey<FormState>();

  List<LabOrdersModel> newOrderList = [];
  List<LabOrdersModel> onProcessOrderList = [];
  List<LabOrdersModel> rejectedOrderList = [];
  List<LabOrdersModel> completedOrderList = [];

  Set<String> newOrderListIds = {};
  Set<String> onProcessOrderListIds = {};

  final deliveryChargeController = TextEditingController();
  final rejectionController = TextEditingController();
  bool isLoading = false;

  String? availableTotalTime;
  String? selectedTimeSlot1;
  String? selectedTimeSlot2;

  TextEditingController dateController = TextEditingController();
  // String? selectedDate;
  // num doorStepCharge;

  // void setDoorStepCharge() {
  //   doorStepCharge = num.tryParse(deliveryChargeController.text)!;
  //   notifyListeners();
  // }

/* ------------------------------ FETCH ORDERS ------------------------------ */
  void getNewOrders({required String labId}) {
    isLoading = true;
    notifyListeners();
    ilabOrdersFacade.getLabOrders(labId: labId).listen((event) {
      event.fold(
        (err) {
          CustomToast.errorToast(text: err.errMsg);
          isLoading = false;
          notifyListeners();
        },
        (newOrders) {
          final uniqueOrders = newOrders
              .where(
                (orders) => !newOrderListIds.contains(orders.id),
              )
              .toList();
          newOrderListIds.addAll(uniqueOrders.map((orders) => orders.id!));
          (orders) => !onProcessOrderListIds.contains(orders.id);
          newOrderList.addAll(uniqueOrders);

          isLoading = false;
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
          final uniqueOrders = onProcessOrders
              .where(
                (orders) => !onProcessOrderListIds.contains(orders.id),
              )
              .toList();
          onProcessOrderListIds
              .addAll(uniqueOrders.map((orders) => orders.id!));

          onProcessOrderList.addAll(uniqueOrders);
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
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  /* -------------------------- GET COMPLETED ORDERS -------------------------- */
  Future<void> getCompletedOrders({required String labId}) async {
    isLoading = true;
    notifyListeners();
    final result = await ilabOrdersFacade.getCompletedOrders(labId: labId);
    result.fold((err) {
      log('error in getCompletedOrders() :: ${err.errMsg}');
    }, (completedOrders) {
      completedOrderList = completedOrders;
    });
    isLoading = false;
    notifyListeners();
  }

  /* ------------------------------- CLEAR DATA ------------------------------- */
  void clearDataRejected() {
    ilabOrdersFacade.clearDataRejected();

    rejectedOrderList = [];
    notifyListeners();
  }

  void cleatDataCompleted() {
    ilabOrdersFacade.clearDataCompleted();
    completedOrderList = [];
    notifyListeners();
  }

  void completeInit(ScrollController scrollController, String labId) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0 &&
            isLoading == false) {
          getCompletedOrders(labId: labId);
        }
      },
    );
  }

  void rejectInit(ScrollController scrollController, String labId) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0 &&
            isLoading == false) {
          getRejectedOrders(labId: labId);
        }
      },
    );
  }

/* ---------------------------- UPDATE ORDER STATUS ---------------------------- */
  Future<void> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      num? finalAmount,
      num? currentAmount,
      String? rejectReason}) async {
    isLoading = true;
    notifyListeners();
    final result = await ilabOrdersFacade.updateOrderStatus(
        finalAmount: finalAmount,
        orderId: orderId,
        orderStatus: orderStatus,
        currentAmount: currentAmount,
        rejectReason: rejectReason);
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

  /* ------------------------------ SET TIME SLOT ----------------------------- */
  Future<void> setTimeSlot(
      {required String orderId, required String dateAndTime}) async {
    final result = await ilabOrdersFacade.setTimeSlot(
        orderId: orderId, dateAndTime: dateAndTime);
    result.fold(
      (err) {
        CustomToast.errorToast(text: err.errMsg);
      },
      (success) {
        CustomToast.sucessToast(text: success);
      },
    );
  }

  void clearTimeSlotData() {
    selectedTimeSlot1 = null;
    selectedTimeSlot2 = null;
    dateController.clear();
    notifyListeners();
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

  /* ------------------------------ LAUNCH DIALER ----------------------------- */
  Future<void> lauchDialer({required String phoneNumber}) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      CustomToast.errorToast(text: 'Could not launch the dialer');
    }
  }

  /* ---------------------------- UPLOAD PDF REPORT --------------------------- */
  File? pdfFile;
  String? pdfUrl;

  Future<void> pickPdfFile() async {
    final result = await ilabOrdersFacade.getPDF();
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
    }, (success) {
      pdfFile = success;
    });
    notifyListeners();
  }

  Future<void> savePdf() async {
    final result = await ilabOrdersFacade.savePDF(pdfFile: pdfFile!);
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
    }, (success) {
      pdfUrl = success;
    });
  }

  Future<void> updateResult({required String orderId}) async {
    log('called provider');
    final result = await ilabOrdersFacade.uploadPdfReport(
        orderId: orderId, pdfUrl: pdfUrl!);
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
    }, (success) {
      CustomToast.sucessToast(text: success);
      pdfFile = null;
      pdfUrl = null;
    });
    notifyListeners();
  }
}
