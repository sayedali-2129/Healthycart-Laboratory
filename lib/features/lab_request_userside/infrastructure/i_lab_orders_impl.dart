import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/core/services/pdf_picker.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/facade/i_lab_orders_facade.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILabOrdersFacade)
class ILabOrdersImpl implements ILabOrdersFacade {
  ILabOrdersImpl(this._firestore, this._pdfService);
  final PdfPickerService _pdfService;

  final FirebaseFirestore _firestore;
  StreamSubscription? newOrderSubscription;
  StreamSubscription? onProcessOrderSubscription;

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  bool noMoreData = false;

  StreamController<Either<MainFailure, List<LabOrdersModel>>>
      newOrderStreamController =
      StreamController<Either<MainFailure, List<LabOrdersModel>>>.broadcast();
  StreamController<Either<MainFailure, List<LabOrdersModel>>>
      onProcessOrderController =
      StreamController<Either<MainFailure, List<LabOrdersModel>>>.broadcast();

/* ------------------------------- NEW ORDERS ------------------------------- */
  @override
  Stream<Either<MainFailure, List<LabOrdersModel>>> getLabOrders(
      {required String labId}) async* {
    try {
      newOrderSubscription = _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .where(Filter.and(Filter('labId', isEqualTo: labId),
              Filter('orderStatus', isEqualTo: 0)))
          .orderBy('orderAt', descending: true)
          .snapshots()
          .listen(
        (doc) {
          final newOrderList = doc.docs
              .map((e) => LabOrdersModel.fromMap(e.data()).copyWith(id: e.id))
              .toList();
          newOrderStreamController.add(
            right(newOrderList),
          );
        },
      );
    } catch (e) {
      newOrderStreamController
          .add(left(MainFailure.generalException(errMsg: e.toString())));
    }
    yield* newOrderStreamController.stream;
  }

/* ---------------------------- ON PROCESS ORDERS --------------------------- */
  @override
  Stream<Either<MainFailure, List<LabOrdersModel>>> getOnProcessOrders(
      {required String labId}) async* {
    try {
      onProcessOrderSubscription = _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .where(Filter.and(Filter('labId', isEqualTo: labId),
              Filter('orderStatus', isEqualTo: 1)))
          .orderBy('acceptedAt', descending: true)
          .snapshots()
          .listen(
        (doc) {
          final onProcessOrderList = doc.docs
              .map((e) => LabOrdersModel.fromMap(e.data()).copyWith(id: e.id))
              .toList();
          onProcessOrderController.add(right(onProcessOrderList));
        },
      );
    } catch (e) {
      onProcessOrderController
          .add(left(MainFailure.generalException(errMsg: e.toString())));
    }
    yield* onProcessOrderController.stream;
  }

/* --------------------------- SET DOORSTEP CHARGE -------------------------- */
  @override
  FutureResult<String> setDeliveryCharge(
      {required String orderId,
      required num charge,
      required num finalAmount}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .doc(orderId)
          .update({'doorStepCharge': charge, 'finalAmount': finalAmount});
      return right('Door step charge updated successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  /* ------------------------------ SET TIME SLOT ----------------------------- */
  @override
  FutureResult<String> setTimeSlot(
      {required String orderId, required String dateAndTime}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .doc(orderId)
          .update({
        'timeSlot': dateAndTime,
      });
      return right('Time slot updated successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

/* ---------------------------- UPDATE ORDER STATUS TO ON PROCESS -------------------------- */
/* -------------------------------------------------------------------------- */
  @override
  FutureResult<String> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      required num? finalAmount,
      required num? currentAmount,
      String? rejectReason}) async {
    try {
      /* ------------------------------ ACCEPT ORDER ------------------------------ */
      if (orderStatus == 1) {
        await _firestore
            .collection(FirebaseCollections.userOrdersCollection)
            .doc(orderId)
            .update(
          {
            'orderStatus': 1,
            'acceptedAt': Timestamp.now(),
          },
        );
        if (finalAmount == 0) {
          await _firestore
              .collection(FirebaseCollections.userOrdersCollection)
              .doc(orderId)
              .update(
            {
              'finalAmount': currentAmount,
            },
          );
        }
        return right('Order Accepted successfully');
        /* ----------------------------- COMPLETE ORDER ----------------------------- */
      } else if (orderStatus == 2) {
        await _firestore
            .collection(FirebaseCollections.userOrdersCollection)
            .doc(orderId)
            .update({'orderStatus': 2});
        return right('Order Completed successfully');
        /* ----------------------------- REJECT ORDER ----------------------------- */
      } else if (orderStatus == 3) {
        await _firestore
            .collection(FirebaseCollections.userOrdersCollection)
            .doc(orderId)
            .update({
          'orderStatus': 3,
          'rejectReason': rejectReason,
          'rejectedAt': Timestamp.now()
        });
        return right('Order Rejected');
      }
      return left(
          const MainFailure.generalException(errMsg: 'Invalid order status'));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  /* --------------------------- GET REJECTED ORDERS -------------------------- */
  @override
  FutureResult<List<LabOrdersModel>> getRejectedOrders(
      {required String labId}) async {
    if (noMoreData) return right([]);
    try {
      Query query = _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .where('labId', isEqualTo: labId)
          .where('orderStatus', isEqualTo: 3)
          .orderBy('rejectedAt', descending: true);

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      final snapshot = await query.limit(4).get();
      if (snapshot.docs.length < 4 || snapshot.docs.isEmpty) {
        noMoreData = true;
      } else {
        lastDoc = snapshot.docs.last as DocumentSnapshot<Map<String, dynamic>>;
      }
      final rejectedOrderList = snapshot.docs
          .map((e) => LabOrdersModel.fromMap(e.data() as Map<String, dynamic>)
              .copyWith(id: e.id))
          .toList();

      return right(rejectedOrderList);
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  /* ---------------------------- UPLOAD PDF REPORT --------------------------- */
  @override
  FutureResult<File> getPDF() async {
    return await _pdfService.getPdfFile();
  }

  @override
  FutureResult<String?> savePDF({
    required File pdfFile,
  }) async {
    return await _pdfService.uploadPdf(pdfFile: pdfFile);
  }

  @override
  FutureResult<String?> deletePDF({
    required String pdfUrl,
  }) async {
    return await _pdfService.deletePdfUrl(url: pdfUrl);
  }

  @override
  FutureResult<String> uploadPdfReport(
      {required String orderId, required String pdfUrl}) async {
    try {
      log('called');
      await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .doc(orderId)
          .update({'resultUrl': pdfUrl});
      log(pdfUrl);
      return right('Result uploaded successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
  /* -------------------------------------------------------------------------- */

  @override
  void clearData() {
    lastDoc = null;
    noMoreData = false;
  }
}
