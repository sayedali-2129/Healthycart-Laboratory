import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/divider/divider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/application/add_banner_provider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/widget/add_new_banner.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class PopupAddBannerDialouge {
  PopupAddBannerDialouge._();
  static final PopupAddBannerDialouge _instance = PopupAddBannerDialouge._();
  static PopupAddBannerDialouge get instance => _instance;

  Future<void> showAddbannerDialouge({
    required BuildContext context,
    required String nameTitle,
    required String buttonText,
    required VoidCallback buttonTap,
    required VoidCallback onAddTap,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddBannerAlertWidget(
            nameTitle: nameTitle,
            buttonTap: buttonTap,
            onAddTap: onAddTap,
            buttonText: buttonText,
          );
        });
  }
}

class AddBannerAlertWidget extends StatelessWidget {
  const AddBannerAlertWidget(
      {super.key,
      required this.nameTitle,
      required this.buttonTap,
      required this.onAddTap,
      required this.buttonText});
  final String nameTitle;
  final VoidCallback buttonTap;
  final VoidCallback onAddTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddBannerProvider>(builder: (context, value, _) {
      return PopScope(
        onPopInvoked: (didPop) {
          value.clearBannerDetails();
        },
        child: AlertDialog(
          contentPadding:
              const EdgeInsets.only(bottom: 16, left: 12, right: 12, top: 8),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: (value.imageFile == null && value.imageUrl == null)
                          ? AddNewBannerWidget(
                              onTap: onAddTap,
                              height: 120,
                              width: 120,
                              child: const Center(child: Icon(Icons.add)),
                            )
                          : (value.imageFile != null)
                              ? AddNewBannerWidget(
                                  height: 200,
                                  width: 260,
                                  onTap: onAddTap,
                                  child: Image.file(
                                    value.imageFile!,
                                  ),
                                )
                              : AddNewBannerWidget(
                                  height: 200,
                                  width: 260,
                                  onTap: onAddTap,
                                  child: Image.network(
                                    value.imageUrl ?? '',
                                  ),
                                )),
                  const Gap(16),
                  Column(children: [
                    DividerWidget(
                      text: nameTitle,
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: buttonTap,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: BColors.buttonLightColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          child: Text(buttonText,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white))),
                    )
                  ]),
                  const Gap(8)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
