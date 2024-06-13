import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/firebase_collection.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/core/services/image_picker.dart';
import 'package:healthy_cart_laboratory/core/services/pdf_picker.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/i_form_facade.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFormFeildFacade)
class IFormFieldImpl implements IFormFeildFacade {
  IFormFieldImpl(this._firebaseFirestore, this._imageService, this._pdfService);
  final FirebaseFirestore _firebaseFirestore;
  final ImageService _imageService;
  final PdfPickerService _pdfService;
  @override
  /////////////adding lab to the collection
  FutureResult<String> addLaboratoryDetails({
    required LaboratoryModel laboratoryDetails,
    required String laboratoryId,
  }) async {
    try {
      final batch = _firebaseFirestore.batch();
      batch.update(
          _firebaseFirestore
              .collection(FirebaseCollections.laboratory)
              .doc(laboratoryId),
          laboratoryDetails.toMap());
      batch.update(
          _firebaseFirestore
              .collection(FirebaseCollections.counts)
              .doc('htfK5JIPTaZVlZi6fGdZ'),
          {'pendingLabs': FieldValue.increment(1)});
      await batch.commit();
      return right('Sucessfully sent for review');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

  @override
  FutureResult<LaboratoryModel> getLaboratoryDetails({
    required String laboratoryId,
  }) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(FirebaseCollections.laboratory)
          .doc(laboratoryId)
          .get();
      return right(LaboratoryModel.fromMap(snapshot.data()!));
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.message.toString()));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }

//Image section -------------------------------------
  @override
  FutureResult<File> getImage() async {
    return await _imageService.getGalleryImage();
  }

  @override
  Future<Either<MainFailure, String>> saveImage(
      {required File imageFile}) async {
    return await _imageService.saveImage(
        imageFile: imageFile, folderName: 'laborator_image');
  }

  @override
  Future<Either<MainFailure, Unit>> deleteImage(
      {required String imageUrl}) async {
    return await _imageService.deleteImageUrl(imageUrl: imageUrl);
  }
///////////////////////////////////////////////////////////////////////////

  @override
  FutureResult<File> getPDF() async {
    return await _pdfService.getPdfFile();
  }

  @override
  FutureResult<String?> savePDF({
    required File pdfFile,
  }) async {
    return await _pdfService.uploadPdf(
        pdfFile: pdfFile, folderName: 'laboratory_pdf');
  }

  @override
  FutureResult<String?> deletePDF({
    required String pdfUrl,
  }) async {
    return await _pdfService.deletePdfUrl(url: pdfUrl);
  }

  ///update section from profile--------------------
  @override
  FutureResult<String> updateLaboratoryForm({
    required LaboratoryModel laboratoryDetails,
    required String laboratoryId,
  }) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollections.laboratory)
          .doc(laboratoryId)
          .update(laboratoryDetails.toEditMap());
      return right('Sucessfully sent for review');
    } on FirebaseException catch (e) {
      return left(MainFailure.firebaseException(errMsg: e.code));
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
