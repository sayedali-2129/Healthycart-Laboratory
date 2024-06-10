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

  @override
  FutureResult<List<LabOrdersModel>> getLabOrders(
      {required String labId}) async {
    try {
      final responce = await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .where(Filter.and(Filter('labId', isEqualTo: labId),
              Filter('orderStatus', isEqualTo: 0)))
          .get();

      final newOrderList = responce.docs
          .map((e) => LabOrdersModel.fromMap(e.data()).copyWith(id: e.id))
          .toList();

      return right(newOrderList);
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<String> setDeliveryCharge(
      {required String orderId, required num charge}) async {
    try {
      await _firestore
          .collection(FirebaseCollections.userOrdersCollection)
          .doc(orderId)
          .update({'doorStepCharge': charge});
      return right('Door step charge updated successfully');
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
