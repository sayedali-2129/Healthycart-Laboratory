import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';

abstract class ILabOrdersFacade {
  Stream<Either<MainFailure, List<LabOrdersModel>>> getLabOrders(
      {required String labId});
  FutureResult<String> setDeliveryCharge(
      {required String orderId, required num charge, required num finalAmount});
  FutureResult<String> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      required num? finalAmount,
      required num? currentAmount,
      String? rejectReason});
  Stream<Either<MainFailure, List<LabOrdersModel>>> getOnProcessOrders({
    required String labId,
  });
  FutureResult<List<LabOrdersModel>> getRejectedOrders({required String labId});
  FutureResult<List<LabOrdersModel>> getCompletedOrders(
      {required String labId});
  FutureResult<String> setTimeSlot(
      {required String orderId, required String dateAndTime});
  FutureResult<File> getPDF();
  FutureResult<String?> savePDF({
    required File pdfFile,
  });
  FutureResult<String?> deletePDF({
    required String pdfUrl,
  });
  FutureResult<String> uploadPdfReport(
      {required String orderId, required String pdfUrl});
  FutureResult<String> updatePaymentStatus({required String orderId});

  void clearDataRejected();
  void clearDataCompleted();
}
