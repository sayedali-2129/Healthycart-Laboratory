import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthy_cart_laboratory/core/custom/text_formfield/textformfield.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/add_test_image_circle.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class TestAddBottomSheet extends StatelessWidget {
  const TestAddBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 640,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularAddImageWidget(
                            addTap: () {},
                            iconSize: 48,
                            height: 120,
                            width: 120,
                            radius: 120),
                        const Gap(25),
                        const TextfieldWidget(
                          labelText: 'Name of Test',
                        ),
                        const Gap(15),
                        const TextfieldWidget(
                          labelText: 'Set Price',
                          keyboardType: TextInputType.number,
                        ),
                        const Gap(15),
                        const TextfieldWidget(
                          labelText: 'Set Offer',
                          keyboardType: TextInputType.number,
                        ),
                        const Gap(20),
                        CustomButton(
                            width: 120,
                            height: 45,
                            onTap: () {},
                            text: 'Save',
                            buttonColor: BColors.darkblue,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: BColors.white))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
