// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
import 'package:healthy_cart_laboratory/core/custom/text_formfield/textformfield.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/core/general/validator.dart';
import 'package:healthy_cart_laboratory/core/services/easy_navigation.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/application/provider/test_provider.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/domain/models/test_model.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/add_test_image_circle.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class TestAddBottomSheet extends StatefulWidget {
  const TestAddBottomSheet({
    super.key,
    required this.onImageTap,
    this.editData,
    required this.labId,
    this.index,
  });
  final void Function() onImageTap;

  final String labId;
  final int? index;
  final TestModel? editData;

  @override
  State<TestAddBottomSheet> createState() => _TestAddBottomSheetState();
}

class _TestAddBottomSheetState extends State<TestAddBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.editData != null) {
          Provider.of<TestProvider>(context, listen: false)
              .setEditData(widget.editData!);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(builder: (context, testProvider, _) {
      return PopScope(
        onPopInvoked: (didPop) {
          testProvider.clearImages();
          testProvider.clearFields();
          testProvider.isDoorStepAvailable = false;
          testProvider.needPrescription = false;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 640,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Form(
                        key: testProvider.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            testProvider.imageFile == null &&
                                    testProvider.imageUrl == null
                                ? CircularAddImageWidget(
                                    addTap: widget.onImageTap,
                                    iconSize: 48,
                                    height: 120,
                                    width: 120,
                                    radius: 120)
                                : (testProvider.imageFile != null)
                                    ? GestureDetector(
                                        onTap: widget.onImageTap,
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: 120,
                                          width: 120,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.file(
                                            testProvider.imageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: widget.onImageTap,
                                        child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 120,
                                            width: 120,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: CustomCachedNetworkImage(
                                                image: testProvider.imageUrl!)),
                                      ),
                            const Gap(25),
                            TextfieldWidget(
                              labelText: 'Name of Test',
                              controller: testProvider.testNameController,
                              validator: BValidator.validate,
                            ),
                            const Gap(15),
                            TextfieldWidget(
                              labelText: 'Set Price',
                              keyboardType: TextInputType.number,
                              controller: testProvider.priceController,
                              validator: BValidator.validate,
                            ),
                            const Gap(15),
                            TextfieldWidget(
                              labelText: 'Set Offer',
                              keyboardType: TextInputType.number,
                              controller: testProvider.offerPriceController,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Text(
                                  'Door Step Available? : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: BColors.black),
                                ),
                                Checkbox(
                                  value: testProvider.isDoorStepAvailable,
                                  onChanged: (value) {
                                    testProvider.doorStepcheckBox();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Prescription Needed? : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: BColors.black),
                                ),
                                Checkbox(
                                  value: testProvider.needPrescription,
                                  onChanged: (value) {
                                    testProvider.prescriptioncheckBox();
                                  },
                                ),
                              ],
                            ),
                            const Gap(20),
                            CustomButton(
                              width: 120,
                              height: 45,
                              text: 'Save',
                              buttonColor: BColors.darkblue,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: BColors.white),
                              onTap: () async {
                                if (!testProvider.formKey.currentState!
                                    .validate()) {
                                  testProvider.formKey.currentState!.validate();
                                } else if (testProvider.imageFile == null &&
                                    testProvider.imageUrl == null) {
                                  CustomToast.errorToast(
                                      text: 'Please Select Image');
                                } else {
                                  LoadingLottie.showLoading(
                                      context: context,
                                      text: widget.editData == null
                                          ? 'Adding Test'
                                          : 'Updating Test...');
                                  if (testProvider.imageUrl == null) {
                                    await testProvider.saveImage();
                                    await testProvider.addNewTest(
                                        labId: widget.labId);
                                  } else {
                                    await testProvider.editTest(
                                        testDetails: widget.editData!,
                                        index: widget.index!,
                                        testId: testProvider
                                            .testList[widget.index!].id!);
                                  }
                                  EasyNavigation.pop(context: context);
                                  EasyNavigation.pop(context: context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
