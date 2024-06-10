import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/user_address_card.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({super.key});

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  @override
  void initState() {
    final orderProvider = context.read<LabOrdersProvider>();
    final authProvider = context.read<AuthenticationProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderProvider.getNewOrders(labId: authProvider.labFetchlDataFetched!.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, ordersProvider, _) {
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.builder(
              itemCount: ordersProvider.newOrderList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: PhysicalModel(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),

                      /////////////////////
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 28,
                                  width: 128,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: BColors.darkblue),
                                  child: Center(
                                    child: Text(
                                        ordersProvider.newOrderList[index].id!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                                Container(
                                  height: 28,
                                  width: 128,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(),
                                      color: BColors.offWhite),
                                  child: Center(
                                    child: Text(
                                      '23/01/2024',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const Gap(8),
                              itemCount: ordersProvider
                                  .newOrderList[index].selectedTest!.length,
                              itemBuilder: (context, testIndex) {
                                return Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ///// IMAGE CIRCLE /////
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          width: 55,
                                          height: 55,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.amber),
                                          child: CustomCachedNetworkImage(
                                              image: ordersProvider
                                                  .newOrderList[index]
                                                  .selectedTest![testIndex]
                                                  .testImage!),
                                        ),
                                        const Gap(8),
                                        Text(
                                          ordersProvider
                                              .newOrderList[index]
                                              .selectedTest![testIndex]
                                              .testName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Gap(8),
                            UserDetailsContainer(
                              userName: ordersProvider.newOrderList[index]
                                      .userDetails!.userName ??
                                  'No',
                              age: ordersProvider
                                  .newOrderList[index].userDetails!.userAge!,
                              phoneNumber: ordersProvider
                                  .newOrderList[index].userDetails!.phoneNo!,
                              gender: ordersProvider.newOrderList[index]
                                      .userAddress!.phoneNumber ??
                                  'no',
                            ),
                            const Gap(8),
                            ordersProvider.newOrderList[index].userAddress!
                                        .address ==
                                    null
                                ? const Gap(0)
                                : AddressCard(index: index),
                            const Gap(8),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    DetailsTexts(
                                        leftText: 'Test Mode',
                                        rightText: ordersProvider
                                            .newOrderList[index].testMode!),
                                    const Gap(5),
                                    const DetailsTexts(
                                        leftText: 'Payment',
                                        rightText: 'Cash On Delivery'),
                                    const Gap(5),
                                    DetailsTexts(
                                        leftText: 'Test Amount',
                                        rightText:
                                            '₹${ordersProvider.newOrderList[index].totalAmount!}'
                                                .toString()),
                                    const Gap(5),
                                    DetailsTexts(
                                        leftText: 'Door Step Charge',
                                        rightText: (ordersProvider
                                                        .newOrderList[index]
                                                        .doorStepCharge !=
                                                    null &&
                                                ordersProvider
                                                        .newOrderList[index]
                                                        .doorStepCharge !=
                                                    0)
                                            ? '₹${ordersProvider.newOrderList[index].doorStepCharge!}'
                                            : '0'),
                                    const Gap(5),
                                    DetailsTexts(
                                      leftText: 'Total Amount',
                                      rightText:
                                          '₹${ordersProvider.finalAmount(ordersProvider.newOrderList[index].doorStepCharge ?? 0, ordersProvider.newOrderList[index].totalAmount!)}',
                                      leftTextSize: 14,
                                      leftTextWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 136,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: BColors.buttonRedShade,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    child: Text('Reject',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                const Gap(8),
                                SizedBox(
                                  height: 40,
                                  width: 136,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        surfaceTintColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    child: Text('Accept',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class DetailsTexts extends StatelessWidget {
  const DetailsTexts({
    super.key,
    required this.leftText,
    required this.rightText,
    this.leftTextSize = 13,
    this.leftTextWeight = FontWeight.w500,
    this.leftColor = Colors.black,
  });
  final String leftText;
  final String rightText;
  final double? leftTextSize;
  final FontWeight? leftTextWeight;
  final Color? leftColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$leftText  :  ',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: leftTextSize,
                fontWeight: leftTextWeight,
                color: leftColor,
              ),
        ),
        Text(
          rightText,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class UserDetailsContainer extends StatelessWidget {
  const UserDetailsContainer({
    super.key,
    required this.userName,
    required this.age,
    required this.phoneNumber,
    required this.gender,
  });
  final String userName;
  final String age;
  final String phoneNumber;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowTwoTextWidget(text1: 'Age', text2: age, gap: 48),
                      Gap(8),
                      RowTwoTextWidget(text1: 'Gender', text2: gender, gap: 24),
                      Gap(8),
                      RowTwoTextWidget(
                          text1: 'Phone No', text2: phoneNumber, gap: 8),
                    ],
                  ),
                ),
                const Gap(12),
                PhysicalModel(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_on_sharp,
                                  size: 24,
                                  color: Colors.blue,
                                ))))),
                const Gap(8),
                PhysicalModel(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.phone,
                                    size: 24, color: Colors.blue))))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowTwoTextWidget extends StatelessWidget {
  const RowTwoTextWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.gap,
  });
  final String text1;
  final String text2;
  final double gap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Gap(gap),
        Text(
          text2,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
