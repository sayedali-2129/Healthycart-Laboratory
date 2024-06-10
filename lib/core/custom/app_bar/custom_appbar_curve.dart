import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';

class CustomCurveAppBarWidget extends StatelessWidget {
  const CustomCurveAppBarWidget({super.key, this.bottom});

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 110,
      backgroundColor: BColors.mainlightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                scale: 2,
                BImage.roundLogo,
                fit: BoxFit.fill,
              ),
              const Gap(10),
              Image.asset(
                scale: 3,
                BImage.appBarText,
                fit: BoxFit.fill,
              ),
            ]),
      ),
      bottom: bottom,
    );
  }
}
