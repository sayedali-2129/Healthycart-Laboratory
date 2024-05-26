import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/laboratory_banner/application/add_banner_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class AdSlider extends StatelessWidget {
  const AdSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddBannerProvider>(
        builder: (context, addBannerProvider, _) {
      return (addBannerProvider.fetchLoading)
          ? Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              height: 202,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: BColors.darkblue,
                ),
              ))
          : CarouselSlider.builder(
              itemCount: addBannerProvider.bannerList.length,
              itemBuilder: (context, index, realIndex) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: (addBannerProvider.bannerList.isEmpty ||
                        addBannerProvider.bannerList[index].image == null)
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: 202,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.auto_awesome_mosaic_outlined,
                              size: 56,
                              color: BColors.darkblue,
                            ),
                            Text(
                              'Add Banner',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    : Container(
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: 202,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomCachedNetworkImage(
                            image: addBannerProvider.bannerList[index].image ??
                                '')),
              ),
              options: CarouselOptions(
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                initialPage: 0,
                autoPlay:
                    addBannerProvider.bannerList.length <= 1 ? false : true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                onPageChanged: (index, reason) {},
              ),
            );
    });
  }
}
