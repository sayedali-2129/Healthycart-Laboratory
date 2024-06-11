import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/facade/i_lab_orders_facade.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/domain/models/lab_orders_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILabOrdersFacade)
class ILabOrdersImpl implements ILabOrdersFacade {
  ILabOrdersImpl(this._firestore);

  final FirebaseFirestore _firestore;
  StreamSubscription? newOrderSubscription;
  StreamSubscription? onProcessOrderSubscription;

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

/* ---------------------------- UPDATE ORDER STATUS TO ON PROCESS -------------------------- */
  @override
  FutureResult<String> updateOrderStatus(
      {required String orderId,
      required int orderStatus,
      required num? finalAmount,
      required num? currentAmount,
      String? rejectionReason}) async {
    try {
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
      } else if (orderStatus == 2) {
        await _firestore
            .collection(FirebaseCollections.userOrdersCollection)
            .doc(orderId)
            .update({'orderStatus': 2});
        return right('Order Completed successfully');
      } else if (orderStatus == 3) {
        await _firestore
            .collection(FirebaseCollections.userOrdersCollection)
            .doc(orderId)
            .update({'orderStatus': 3, 'rejectionReason': rejectionReason});
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
    try {
      final responce = await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .where('labId', isEqualTo: labId)
          .where('orderStatus', isEqualTo: 3)
          .get();

      final rejectedOrderList = responce.docs
          .map((e) => LabOrdersModel.fromMap(e.data()).copyWith(id: e.id))
          .toList();
      return right(rejectedOrderList);
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
