import 'package:dartz/dartz.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/services/url_launcher.dart';
import 'package:healthy_cart_laboratory/features/pending_page/domain/i_pending_facade.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IPendingFacade)
class IPendingImpl implements IPendingFacade {
  IPendingImpl(this._urlService);
  final UrlService _urlService;
  @override
  Future<Either<MainFailure, String>> reDirectToWhatsApp({
    required String whatsAppLink,
  }) async {
    try {
      final result = await _urlService.redirectToWhatsapp(whatsAppLink);
      if (result) {
        return right('');
      } else {
        return left(const MainFailure.generalException(errMsg: "Couldn't ab"));
      }
    } catch (e) {
      return left(MainFailure.generalException(errMsg: e.toString()));
    }
  }
}
