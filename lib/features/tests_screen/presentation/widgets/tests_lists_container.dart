import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/application/provider/test_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class TestsListContainer extends StatelessWidget {
  const TestsListContainer({
    super.key,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });
  final int index;
  final void Function() onDelete;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Consumer<TestProvider>(builder: (context, testProvider, _) {
      final tests = testProvider.testList[index];
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
                clipBehavior: Clip.antiAlias,
                width: 58,
                height: 58,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CustomCachedNetworkImage(image: tests.testImage!),
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            tests.testName ?? 'No Name',
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
                            child: tests.isDoorstepAvailable == true
                                ? Text(
                                    'Door Step Available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: BColors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    'Lab Only',
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
                    const Gap(10),
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
                            text: '₹${tests.testPrice}',
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
                            text: 'Offer Price - ',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: BColors.mainlightColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '₹${tests.offerPrice}',
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
              PopupMenuButton(
                color: BColors.white,
                child: const Icon(
                  Icons.edit_outlined,
                  color: BColors.black,
                  size: 26,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: onEdit,
                    child: Text(
                      'Edit',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onDelete,
                    child: Text(
                      'Delete',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
