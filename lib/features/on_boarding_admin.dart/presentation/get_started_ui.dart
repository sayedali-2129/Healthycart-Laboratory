import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/main_logo_appbar.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';

import 'package:healthy_cart_laboratory/features/on_boarding_admin.dart/presentation/select_admin_ui.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const AppBarCurved(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Image.asset(width: 218, height: 184, BImage.getStartedImage),
                const Gap(48),
                Text(
                  'Get things done with HEALTHY CART',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const Gap(16),
                const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the ,",
                  textAlign: TextAlign.center,
                ),
                const Gap(88),
                CustomButton(
                  width: double.infinity,
                  height: 54,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()));
                  },
                  text: 'Get Started',
                  buttonColor: BColors.buttonLightColor,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: BColors.textWhite),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
