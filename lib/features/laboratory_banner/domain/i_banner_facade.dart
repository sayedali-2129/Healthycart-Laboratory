import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/domain/model/laboratory_banner_model.dart';

abstract class IBannerFacade {
  FutureResult<File> getImage();
  FutureResult<String> saveImage({required File imageFile});
  FutureResult<Unit> deleteImage({required String imageUrl});
  FutureResult<LaboratoryBannerModel> addLaboratoryBanner({
    required LaboratoryBannerModel banner,
  });
  FutureResult<LaboratoryBannerModel> deleteLaboratoryBanner({
    required LaboratoryBannerModel banner,
  });
  FutureResult<List<LaboratoryBannerModel>> getLaboratoryBanner({
    required String hospitalId,
  });
}
