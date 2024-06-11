import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';

class NoDataImageWidget extends StatelessWidget {
  const NoDataImageWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          BImage.noData,
          scale: 2.5,
        ),
        const Gap(15),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: BColors.black, fontWeight: FontWeight.w500),
        ),
      ],
    ));
  }
}
