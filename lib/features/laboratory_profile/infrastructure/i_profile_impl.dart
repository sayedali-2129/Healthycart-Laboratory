import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/domain/i_profile_facade.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/domain/models/transfer_transaction_model.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileFacade)
class IProfileImpl implements IProfileFacade {
  IProfileImpl(this._firebaseFirestore);
  final FirebaseFirestore _firebaseFirestore;

  @override
  FutureResult<List<TestModel>> getTests() async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(FirebaseCollections.laboratoryTests)
          .orderBy('createdAt')
          .get();
      return right(snapshot.docs
          .map((e) => TestModel.fromMap(e.data()).copyWith(id: e.id))
          .toList());
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<String> setActiveLaboratory({
    required bool isLabON,
    required String labId,
  }) async {
    final batch = _firebaseFirestore.batch();

    try {
      batch.update(
          _firebaseFirestore
              .collection(FirebaseCollections.laboratory)
              .doc(labId),
          {'isLabotaroryOn': isLabON});

      if (isLabON == true) {
        batch.update(
            _firebaseFirestore
                .collection(FirebaseCollections.counts)
                .doc('htfK5JIPTaZVlZi6fGdZ'),
            {
              'activeLaboratories': FieldValue.increment(1),
              'inActiveLaboratories': FieldValue.increment(-1)
            });
      } else {
        batch.update(
            _firebaseFirestore
                .collection(FirebaseCollections.counts)
                .doc('htfK5JIPTaZVlZi6fGdZ'),
            {
              'activeLaboratories': FieldValue.increment(-1),
              'inActiveLaboratories': FieldValue.increment(1)
            });
      }

      await batch.commit();

      return right('Successfully updated');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  bool noMoreData = false;
  @override
  FutureResult<List<TransferTransactionsModel>> getAdminTransactionList(
      {required String labId}) async {
    if (noMoreData) return right([]);

    int limit = lastDoc == null ? 15 : 8;
    try {
      Query query = _firebaseFirestore
          .collection(FirebaseCollections.labTransactions)
          .doc(labId)
          .collection(FirebaseCollections.laboratoryTransactionSubCollection)
          .orderBy('dateAndTime', descending: true);

      // if (search != null && search.isNotEmpty) {
      //   query = query.where('keywords', arrayContains: search.toLowerCase());
      // }
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      final result = await query.limit(limit).get();

      if (result.docs.length < limit || result.docs.isEmpty) {
        noMoreData = true;
      } else {
        lastDoc = result.docs.last as DocumentSnapshot<Map<String, dynamic>>;
      }

      final transactionList = result.docs
          .map((e) => TransferTransactionsModel.fromMap(
              e.data() as Map<String, dynamic>))
          .toList();

      return right(transactionList);
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  void clearTransactionData() {
    lastDoc = null;
    noMoreData = false;
  }
}
