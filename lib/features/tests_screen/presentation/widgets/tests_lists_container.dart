import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class TestsListContainer extends StatelessWidget {
  const TestsListContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ///// IMAGE CIRCLE /////
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.amber),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Blood Test skmcsdcksdkcsdkcdskcsdkcsdlkclksdclkd[clkasd]',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Gap(10),
                      Container(
                        height: 23,
                        width: 118,
                        decoration: BoxDecoration(
                            color: BColors.grey,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Door Step Available',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: BColors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Test Fee - ',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: BColors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '₹500',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: BColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                        )
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Offer - ',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: BColors.mainlightColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '₹500',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: BColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                        )
                      ]))
                    ],
                  )
                ],
              ),
            ),
            const Gap(8),
            const Icon(
              Icons.edit_outlined,
              color: BColors.black,
              size: 26,
            )
          ],
        ),
      ),
    );
  }
}
