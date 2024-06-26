import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthy_cart_laboratory/core/custom/keyword_builder/keyword_builder.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/core/failures/main_failure.dart';
import 'package:healthy_cart_laboratory/core/general/typdef.dart';
import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/i_form_facade.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/presentation/location.dart';
import 'package:healthy_cart_laboratory/utils/constants/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

@injectable
class LaboratoryFormProvider extends ChangeNotifier {
  LaboratoryFormProvider(this._iFormFeildFacade);
  final IFormFeildFacade _iFormFeildFacade;

//Image section
  String? imageUrl;
  File? imageFile;
  bool fetchLoading = false;

  Future<void> getImage() async {
    final result = await _iFormFeildFacade.getImage();
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      notifyListeners();
    }, (imageFilesucess) async {
      if (imageUrl != null) {
        await _iFormFeildFacade.deleteImage(imageUrl: imageUrl!);
        imageUrl = null;
      } // when editing  this will make the url null when we pick a new file
      imageFile = imageFilesucess;
      notifyListeners();
    });
  }

  Future<void> saveImage() async {
    if (imageFile == null) {
      CustomToast.errorToast(text: 'Please check the image selected.');
      return;
    }
    final result = await _iFormFeildFacade.saveImage(imageFile: imageFile!);
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
    }, (imageurlGet) {
      imageUrl = imageurlGet;
      notifyListeners();
    });
  }

  final TextEditingController labNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<String> keywordLabBuider() {
    return keywordsBuilder(labNameController.text);
  }

  LaboratoryModel? labDetail;
  String? laboratoryId = FirebaseAuth.instance.currentUser?.uid;
  Placemark? placemark;
  AdminType? adminType;
  Future<void> addLabForm({
    required BuildContext context,
  }) async {
    keywordLabBuider();
    labDetail = LaboratoryModel(
        createdAt: Timestamp.now(),
        keywords: keywordLabBuider(),
        phoneNo: phoneNumberController.text,
        laboratoryName: labNameController.text,
        address: addressController.text,
        ownerName: ownerNameController.text,
        uploadLicense: pdfUrl,
        image: imageUrl,
        id: laboratoryId,
        requested: 1,
        email: emailController.text,
        isActive: true);

    final result = await _iFormFeildFacade.addLaboratoryDetails(
        laboratoryDetails: labDetail!, laboratoryId: laboratoryId!);
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      Navigator.pop(context);
    }, (sucess) {
      clearAllData();
      CustomToast.sucessToast(text: sucess);
      Navigator.pop(context);
      EasyNavigation.pushReplacement(
        type: PageTransitionType.bottomToTop,
        context: context,
        page: const LocationPage(),
      );
      notifyListeners();
    });
  }

  void clearAllData() {
    labNameController.clear();
    addressController.clear();
    adminType = null;
    pdfFile = null;
    pdfUrl = null;
    phoneNumberController.clear();
    ownerNameController.clear();
    notifyListeners();
  }

/////////////////////////// pdf-----------
  ///

  File? pdfFile;
  String? pdfUrl;

  Future<void> getPDF({required BuildContext context}) async {
    final result = await _iFormFeildFacade.getPDF();
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      notifyListeners();
    }, (pdfFileSucess) async {
      pdfUrl = null;

      pdfFile = pdfFileSucess;
      LoadingLottie.showLoading(context: context, text: 'Adding PDF...');
      await savePDF().then((value) {
        // save PDF function is called here......
        value.fold((failure) {
          EasyNavigation.pop(context: context);
          notifyListeners();
          return CustomToast.errorToast(text: failure.errMsg);
        }, (pdfUrlSucess) {
          pdfUrl = pdfUrlSucess;
          EasyNavigation.pop(context: context);
          notifyListeners();
          return CustomToast.sucessToast(text: 'PDF Added Sucessfully');
        });
      });
    });
  }

  FutureResult<String?> savePDF() async {
    if (pdfFile == null) {
      return left(const MainFailure.generalException(
          errMsg: 'Please check the file selected.'));
    }
    final result = await _iFormFeildFacade.savePDF(pdfFile: pdfFile!);
    return result;
  }

  Future<void> deletePDF() async {
    if ((pdfUrl ?? '').isEmpty) {
      pdfFile = null;
      pdfUrl = null;
      CustomToast.errorToast(text: 'PDF removed.');
      notifyListeners();
      return;
    }
    final result = await _iFormFeildFacade.deletePDF(pdfUrl: pdfUrl!);
    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      notifyListeners();
    }, (sucess) {
      pdfFile = null;
      pdfUrl = null;
      CustomToast.sucessToast(text: sucess!);
      notifyListeners();
    });
  }

  ///edit data from the profile section
  void setEditData(LaboratoryModel labDetailsEdit) {
    labNameController.text = labDetailsEdit.laboratoryName ?? '';
    addressController.text = labDetailsEdit.address ?? '';
    phoneNumberController.text = labDetailsEdit.phoneNo ?? '';
    ownerNameController.text = labDetailsEdit.ownerName ?? '';
    pdfUrl = labDetailsEdit.uploadLicense;
    imageUrl = labDetailsEdit.image;
    emailController.text = labDetailsEdit.email ?? '';
    notifyListeners();
  }

  Future<void> updateLabForm({
    required BuildContext context,
  }) async {
    keywordLabBuider();
    labDetail = LaboratoryModel(
      keywords: keywordLabBuider(),
      phoneNo: phoneNumberController.text,
      laboratoryName: labNameController.text,
      address: addressController.text,
      ownerName: ownerNameController.text,
      uploadLicense: pdfUrl,
      image: imageUrl,
      email: emailController.text,
    );

    final result = await _iFormFeildFacade.updateLaboratoryForm(
        laboratoryDetails: labDetail!, laboratoryId: laboratoryId!);

    result.fold((failure) {
      CustomToast.errorToast(text: failure.errMsg);
      Navigator.pop(context);
    }, (sucess) {
      clearAllData();
      CustomToast.sucessToast(text: 'Sucessfully updated.');
      Navigator.pop(context);
      EasyNavigation.pop(context: context);
      // when edited moving back to the profile screen
      notifyListeners();
    });
  }
}
