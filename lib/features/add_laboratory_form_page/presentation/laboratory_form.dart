// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/sliver_appbar.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthy_cart_laboratory/core/custom/divider/divider.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
import 'package:healthy_cart_laboratory/core/custom/text_formfield/textformfield.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/core/general/validator.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/application/laboratory_form_provider.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/domain/model/laboratory_model.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/presentation/widgets/container_image_widget.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/presentation/widgets/pdf_shower_widget.dart';
import 'package:healthy_cart_laboratory/features/add_laboratory_form_page/presentation/widgets/text_above_form_widdget.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/application/location_provider.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/domain/model/location_model.dart';
import 'package:healthy_cart_laboratory/features/location_picker/location_picker/presentation/location_search.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class LaboratoryFormScreen extends StatelessWidget {
  const LaboratoryFormScreen(
      {super.key, this.phoneNo, this.laboratoryModel, this.placeMark});
  final LaboratoryModel? laboratoryModel;
  final String? phoneNo;
  final PlaceMark? placeMark;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (laboratoryModel != null) {
        context.read<LaboratoryFormProvider>().setEditData(laboratoryModel!);
      }
    });
    final GlobalKey<FormState> formKey = GlobalKey<
        FormState>(); // authenication provider is getting here to show the location details
    return Consumer2<LaboratoryFormProvider, AuthenticationProvider>(
        builder: (context, formProvider, authProvider, _) {
      formProvider.phoneNumberController.text = phoneNo ?? '';
      return Scaffold(
          backgroundColor: const Color(0xFFF5F3F3),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                (laboratoryModel != null)
                    ? SliverCustomAppbar(
                        title: 'Edit Profile',
                        onBackTap: () {
                          Navigator.pop(context);
                        },
                      )
                    : const SliverToBoxAdapter(),
                SliverFillRemaining(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (laboratoryModel != null)
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: BColors.mainlightColor,
                                        ),
                                        SizedBox(
                                          width: 176,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<LocationProvider>()
                                                  .getLocationPermisson()
                                                  .then(
                                                (value) {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UserLocationSearchWidget(
                                                            isHospitaEditProfile:
                                                                true),
                                                  ));
                                                },
                                              );
                                            },
                                            child: Text(
                                              "${authProvider.labFetchlDataFetched?.placemark?.localArea},${authProvider.labFetchlDataFetched?.placemark?.district},${authProvider.labFetchlDataFetched?.placemark?.state}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: BColors.darkblue,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            const Gap(24),
                            const ImageFormContainerWidget(),
                            const Gap(16),
                            const DividerWidget(text: 'Tap above to add image'),
                            const Gap(24),
                            const TextAboveFormFieldWidget(
                                text: "Phone Number"),
                            TextfieldWidget(
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              validator: BValidator.validate,
                              controller: formProvider.phoneNumberController,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Gap(8),
                            //hospital Name
                            const TextAboveFormFieldWidget(
                              text: "Laboratory Name",
                            ),

                            TextfieldWidget(
                              hintText: 'Enter Laboratory name',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.multiline,
                              minlines: 1,
                              maxlines: 2,
                              validator: BValidator.validate,
                              controller: formProvider.hospitalNameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Gap(8),

                            const TextAboveFormFieldWidget(
                                text: "Proprietor Name"),
                            TextfieldWidget(
                              hintText: 'Enter Proprietor name',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              validator: BValidator.validate,
                              controller: formProvider.ownerNameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Gap(8),

                            const TextAboveFormFieldWidget(
                                text: "Laboratory Address"),
                            TextfieldWidget(
                              hintText: 'Enter Laboratory address',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.multiline,
                              validator: BValidator.validate,
                              controller: formProvider.addressController,
                              maxlines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Gap(16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await formProvider.getPDF(
                                      context: context); /////////pdf Section
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor: BColors.buttonLightColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Upload License',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontSize: 16,
                                                color: BColors.white)),
                                    const Icon(
                                      Icons.upload_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(16),

                            (formProvider.pdfUrl != null)
                                ? Center(
                                    child: PDFShowerWidget(
                                      formProvider: formProvider,
                                    ),
                                  )
                                : const DividerWidget(
                                    text: 'Upload document as PDF'),
                            const Gap(24),
                            CustomButton(
                                width: double.infinity,
                                height: 48,
                                onTap: () async {
                                  if (formProvider.imageFile == null &&
                                      formProvider.imageUrl == null) {
                                    CustomToast.errorToast(
                                        text: 'Pick Laboratory image');
                                    return;
                                  }
                                  if (!formKey.currentState!.validate()) {
                                    formKey.currentState!.validate();
                                    return;
                                  }
                                  if (formProvider.pdfFile == null &&
                                      formProvider.pdfUrl == null) {
                                    CustomToast.errorToast(
                                        text:
                                            'Pick a Laboratory liscense document.');
                                    return;
                                  }
                                  LoadingLottie.showLoading(
                                      context: context, text: 'Please wait...');
                                  if (laboratoryModel == null) {
                                    await formProvider
                                        .saveImage()
                                        .then((value) async {
                                      await formProvider.addHospitalForm(
                                          context: context);
                                    });
                                  } else {
                                    if (formProvider.imageUrl == null) {
                                      await formProvider.saveImage();
                                    }

                                    await formProvider.updateHospitalForm(
                                      context: context,
                                    );
                                  }
                                },
                                text: (laboratoryModel == null)
                                    ? 'Send for review'
                                    : 'Update details',
                                buttonColor: BColors.buttonDarkColor,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        fontSize: 18, color: BColors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
