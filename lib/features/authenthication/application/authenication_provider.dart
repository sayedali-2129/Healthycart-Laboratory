import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/presentation/laboratory_form.dart';
import 'package:healthy_cart_laboratory/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthy_cart_laboratory/features/authenthication/presentation/otp_ui.dart';
import 'package:healthy_cart_laboratory/features/home/presentation/home.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/presentation/location.dart';
import 'package:healthy_cart_laboratory/features/pending_page/presentation/pending_page.dart';
import 'package:healthy_cart_laboratory/features/splash_screen/splash_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

@injectable
class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider(this.iAuthFacade);
  final IAuthFacade iAuthFacade;
  LaboratoryModel? labFetchlDataFetched;
  String? verificationId;
  String? smsCode;
  final TextEditingController phoneNumberController = TextEditingController();
  String? countryCode;
  String? phoneNumber;
  String? userId;
  int? isRequsetedPendingPage;

  void setNumber() {
    phoneNumber = '$countryCode${phoneNumberController.text.trim()}';
    notifyListeners();
  }

  void labStreamFetchData(
      {required String userId, required BuildContext context}) {
    iAuthFacade.laboratoryStreamFetchData(userId).listen((event) {
      event.fold((failure) {}, (snapshot) {
        labFetchlDataFetched = snapshot;
        isRequsetedPendingPage = snapshot.requested;
        notifyListeners();
      });
    });
  }

  bool labStreamFetchedData({required String labId}) {
    bool result = false;
    iAuthFacade.laboratoryStreamFetchData(labId).listen((event) {
      event.fold((failure) {
        result = false;
      }, (snapshot) {
        labFetchlDataFetched = snapshot;
        isRequsetedPendingPage = snapshot.requested;
        result = true;
        notifyListeners();
      });
    });
    return result;
  }

  void navigationLaboratoryFuction({required BuildContext context}) async {
    if (labFetchlDataFetched?.address == null ||
        labFetchlDataFetched?.image == null ||
        labFetchlDataFetched?.laboratoryName == null ||
        labFetchlDataFetched?.uploadLicense == null ||
        labFetchlDataFetched?.ownerName == null) {
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page:
            LaboratoryFormScreen(phoneNo: labFetchlDataFetched?.phoneNo ?? ''),
      );
      notifyListeners();
    } else if (labFetchlDataFetched?.placemark == null) {
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page: const LocationPage(),
      );
      notifyListeners();
    } else if ((labFetchlDataFetched?.requested == 0 ||
            labFetchlDataFetched?.requested == 1) &&
        labFetchlDataFetched?.placemark != null) {
      EasyNavigation.pushReplacement(
          type: PageTransitionType.bottomToTop,
          context: context,
          page: const PendingPageScreen());
      notifyListeners();
    } else {
      EasyNavigation.pushAndRemoveUntil(
          type: PageTransitionType.bottomToTop,
          context: context,
          page: const HomeScreen());
      notifyListeners();
    }
  }

  void verifyPhoneNumber({required BuildContext context}) {
    iAuthFacade.verifyPhoneNumber(phoneNumber!).listen((result) {
      result.fold((failure) {
        Navigator.pop(context);
        CustomToast.errorToast(text: failure.errMsg);
      }, (isVerified) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => OTPScreen(
                      verificationId: verificationId ?? 'No veriId',
                      phoneNumber: phoneNumber ?? 'No Number',
                    ))));
      });
    });
  }

  Future<void> verifySmsCode(
      {required String smsCode, required BuildContext context}) async {
    final result = await iAuthFacade.verifySmsCode(smsCode: smsCode);
    result.fold((failure) {
      Navigator.pop(context);
      CustomToast.errorToast(text: failure.errMsg);
    }, (userId) {
      userId = userId;
      Navigator.pop(context);
      EasyNavigation.pushReplacement(
          context: context, page: const SplashScreen());
    });
  }

  Future<void> laboratoryLogOut({required BuildContext context}) async {
    final result = await iAuthFacade.laboratoryLogOut();
    result.fold((failure) {
      Navigator.pop(context);
      CustomToast.errorToast(text: failure.errMsg);
    }, (sucess) {
      Navigator.pop(context);
      CustomToast.sucessToast(text: sucess);
      EasyNavigation.pushReplacement(
          context: context, page: const SplashScreen());
    });
  }
}
