import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';

class SelectedTestsCard extends StatelessWidget {
  const SelectedTestsCard({
    super.key,
    required this.image,
    required this.testName,
  });

  final String image;
  final String testName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///// IMAGE CIRCLE /////
            Container(
              clipBehavior: Clip.antiAlias,
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.amber),
              child: CustomCachedNetworkImage(image: image),
            ),
            const Gap(8),
            Text(
              testName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
