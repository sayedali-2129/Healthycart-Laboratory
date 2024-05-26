// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_lottie.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/application/add_banner_provider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/widget/ad_slider.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/widget/add_banner_popup_widget.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/widget/add_new_banner.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/presentation/widget/banner_image_grid.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<AddBannerProvider>(context, listen: false).getBanner();
    });
    PopupAddBannerDialouge popUp = PopupAddBannerDialouge.instance;
    return Consumer<AddBannerProvider>(
        builder: (context, addBannerProvider, _) {
      return CustomScrollView(
        slivers: [
          const CustomCurveAppBarWidget(),
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: AdSlider(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Add or Edit Banner's",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          (addBannerProvider.fetchLoading)

              /// loading is done here
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(
                        color: BColors.darkblue,
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid.builder(
                    itemCount: addBannerProvider.bannerList.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 104),
                    itemBuilder: (context, index) {
                      if (index == addBannerProvider.bannerList.length) {
                        return AddNewBannerWidget(
                          onTap: () {
                            popUp.showAddbannerDialouge(
                              context: context,
                              nameTitle: 'Tap to add banner',
                              buttonText: 'Save',
                              onAddTap: () {
                                addBannerProvider.getImage();
                              },
                              buttonTap: () async {
                                if (addBannerProvider.imageFile == null) {
                                  CustomToast.errorToast(
                                      text: 'Pick a banner image');
                                  return;
                                }
                                LoadingLottie.showLoading(
                                    context: context, text: 'Adding Banner...');
                                await addBannerProvider
                                    .saveImage()
                                    .then((value) async {
                                  await addBannerProvider.addBanner(
                                      context: context);
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                          child: const Center(child: Icon(Icons.add)),
                        );
                      } else {
                        return BannerImageWidget(
                          index: index,
                          indexNumber: '${index + 1}',
                          bannerData: addBannerProvider.bannerList[index],
                        );
                      }
                    },
                  ),
                )
        ],
      );
    });
  }
}
