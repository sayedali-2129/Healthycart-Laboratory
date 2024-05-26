import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';

import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';

abstract class IAuthFacade {
  //factory IAuthFacade() => IAuthImpl(FirebaseAuth.instance);
  Stream<Either<MainFailure, bool>> verifyPhoneNumber(String phoneNumber);
  Future<Either<MainFailure, String>> verifySmsCode({
    required String smsCode,
  });

  Stream<Either<MainFailure, LaboratoryModel>> laboratoryStreamFetchData(
      String userId);

  Future<Either<MainFailure, String>> laboratoryLogOut();
  Future<void> cancelStream();
}
