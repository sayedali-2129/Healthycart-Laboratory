// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class OnProcessAddress extends StatelessWidget {
  const OnProcessAddress({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, orderProvider, _) {
      return Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Door Step Address :-',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: BColors.black),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              orderProvider
                                  .onProcessOrderList[index].userAddress!.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: BColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Gap(8),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                  child: Text(
                                    orderProvider.onProcessOrderList[index]
                                        .userAddress!.addressType!,
                                    style: const TextStyle(
                                        color: BColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Text(
                          '${orderProvider.onProcessOrderList[index].userAddress!.address ?? 'Address'} ${orderProvider.onProcessOrderList[index].userAddress!.landmark ?? 'Address'} - ${orderProvider.onProcessOrderList[index].userAddress!.pincode ?? 'Address'}',
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 3,
                          style: const TextStyle(
                              color: BColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const Gap(5)
                      ],
                    ),
                    Text(
                      orderProvider
                          .onProcessOrderList[index].userAddress!.phoneNumber!,
                      style: const TextStyle(
                          color: BColors.black, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
