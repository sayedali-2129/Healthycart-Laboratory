import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';

abstract class IFormFeildFacade {
  FutureResult<String> addLaboratoryDetails({
    required LaboratoryModel laboratoryDetails,
    required String laboratoryId,
  });
  FutureResult<LaboratoryModel> getLaboratoryDetails(
      {required String laboratoryId});
  FutureResult<File> getImage();
  FutureResult<String> saveImage({
    required File imageFile,
  });
  FutureResult<Unit> deleteImage({
    required String imageUrl,
  });
  FutureResult<String> updateLaboratoryForm({
    required LaboratoryModel laboratoryDetails,
    required String laboratoryId,
  });
  FutureResult<File> getPDF();
  FutureResult<String?> savePDF({
    required File pdfFile,
  });
  FutureResult<String?> deletePDF({
    required String pdfUrl,
  });
}
