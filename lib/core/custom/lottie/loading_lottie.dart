import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie {
  static showLoading({required BuildContext context, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              contentPadding: const EdgeInsets.only(bottom: 16),
              backgroundColor: Colors.white70,
              surfaceTintColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(BImage.labloading,
                      fit: BoxFit.fill, height: 100, width: 100),
                  Text(
                    text,
                    style:
                        TextStyle(color: BColors.backgroundRoundContainerColor),
                  )
                ],
              ),
            ),
          );
        });
  }
}
