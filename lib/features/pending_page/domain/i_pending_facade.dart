import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';

abstract class IPendingFacade {
  Future<Either<MainFailure, String>> reDirectToWhatsApp(
      {required String whatsAppLink});
}
