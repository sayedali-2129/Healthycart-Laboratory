import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/clip_path_header.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';

class AppBarCurved extends StatelessWidget {
  const AppBarCurved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipperPath(),
          child: Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                color: BColors.backgroundRoundContainerColor,
              )),
        ),
        Positioned(
          top: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(12),
              Image.asset(
                height: 100,
                BImage.logo,
                fit: BoxFit.fill,
              ),
              Image.asset(height: 49, width: 227, BImage.logoAppName),
            ],
          ),
        )
      ],
    );
  }
}
