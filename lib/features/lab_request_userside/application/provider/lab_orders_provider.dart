import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
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

  Set<String> orderIds = {};

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
        final uniqueOrders = rejectedOrders
            .where(
              (orders) => !orderIds.contains(orders.id),
            )
            .toList();
        orderIds.addAll(uniqueOrders.map((orders) => orders.id!));
        rejectedOrderList.addAll(uniqueOrders);
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  /* ------------------------------- CLEAR DATA ------------------------------- */
  void clearData() {
    ilabOrdersFacade.clearData();
    orderIds.clear();
    rejectedOrderList = [];
    notifyListeners();
  }

  void init(ScrollController scrollController, String labId) {
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

  Future<void> getPDF({required BuildContext context}) async {
    final result = await ilabOrdersFacade.getPDF();
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      notifyListeners();
    }, (pdfFileSucess) async {
      pdfUrl = null;

      pdfFile = pdfFileSucess;
      LoadingLottie.showLoading(context: context, text: 'Adding PDF...');
      await savePDF().then((value) {
        // save PDF function is called here......
        value.fold((failure) {
          EasyNavigation.pop(context: context);
          notifyListeners();
          return CustomToast.errorToast(text: failure.errMsg);
        }, (pdfUrlSucess) {
          pdfUrl = pdfUrlSucess;
          log(pdfUrl ?? 'null');

          notifyListeners();
        });
      });
    });
  }

  FutureResult<String?> savePDF() async {
    if (pdfFile == null) {
      return left(const MainFailure.generalException(
          errMsg: 'Please check the file selected.'));
    }
    final result = await ilabOrdersFacade.savePDF(pdfFile: pdfFile!);
    return result;
  }

  Future<void> deletePDF() async {
    if ((pdfUrl ?? '').isEmpty) {
      pdfFile = null;
      pdfUrl = null;
      CustomToast.errorToast(text: 'PDF removed.');
      notifyListeners();
      return;
    }
    final result = await ilabOrdersFacade.deletePDF(pdfUrl: pdfUrl!);
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      notifyListeners();
    }, (sucess) {
      pdfFile = null;
      pdfUrl = null;
      CustomToast.sucessToast(text: sucess!);
      notifyListeners();
    });
  }

  Future<void> updateResult({required String orderId}) async {
    final result = await ilabOrdersFacade.uploadPdfReport(
        orderId: orderId, pdfUrl: pdfUrl!);
    result.fold((err) {
      CustomToast.errorToast(text: err.errMsg);
    }, (success) {
      CustomToast.sucessToast(text: success);
    });
    notifyListeners();
  }
}
