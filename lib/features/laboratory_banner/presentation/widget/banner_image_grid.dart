import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/confirm_alertbox/confirm_delete_widget.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/application/add_banner_provider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/domain/model/laboratory_banner_model.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    super.key,
    required this.indexNumber,
    required this.bannerData,
    required this.index,
  });
  final String indexNumber;
  final LaboratoryBannerModel bannerData;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<AddBannerProvider>(
        builder: (context, addBannerProvider, _) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomCachedNetworkImage(image: bannerData.image ?? '')),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Positioned(
              left: 4,
              top: 4,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Text(
                  indexNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              )),
          GestureDetector(
            onTap: () {
              ConfirmAlertBoxWidget.showAlertConfirmBox(
                context: context,
                confirmButtonTap: () {
                  addBannerProvider.deleteBanner(
                    bannerToDelete: bannerData,
                    imageUrl: bannerData.image ?? '',
                    context: context,
                    index: index,
                  );
                },
                titleText: 'Confirm to remove banner',
                subText: 'Are you sure tou want to remove this banner?',
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: BColors.lightGrey.withOpacity(.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remove",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  const Gap(8),
                  const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
