import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class AddNewBannerWidget extends StatelessWidget {
  const AddNewBannerWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.width,
    this.height,
  });
  final void Function() onTap;
  final Widget child;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: BColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
