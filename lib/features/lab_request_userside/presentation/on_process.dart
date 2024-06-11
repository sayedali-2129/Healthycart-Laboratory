import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/button_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/no_data_widget.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/new_request.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/on_process_address.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/icon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OnProcess extends StatefulWidget {
  const OnProcess({super.key});

  @override
  State<OnProcess> createState() => _OnProcessState();
}

class _OnProcessState extends State<OnProcess> {
  @override
  void initState() {
    final orderProvider = context.read<LabOrdersProvider>();
    final authProvider = context.read<AuthenticationProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderProvider.getOnProcessOrders(
          labId: authProvider.labFetchlDataFetched!.id!);
      log(orderProvider.onProcessOrderList.length.toString());
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
            sliver: ordersProvider.onProcessOrderList.isEmpty
                ? const SliverFillRemaining(
                    child: NoDataImageWidget(
                        text: 'No Processing Requests Found!'))
                : SliverList.separated(
                    itemCount: ordersProvider.onProcessOrderList.length,
                    separatorBuilder: (context, index) => const Gap(8),
                    itemBuilder: (context, index) {
                      final orderDate = ordersProvider
                          .onProcessOrderList[index].acceptedAt!
                          .toDate();
                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(orderDate);
                      return PhysicalModel(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: BColors.darkblue),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            ordersProvider
                                                .onProcessOrderList[index].id!,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(),
                                          color: BColors.offWhite),
                                      child: Center(
                                        child: Text(
                                          formattedDate,
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
                                      .onProcessOrderList[index]
                                      .selectedTest!
                                      .length,
                                  itemBuilder: (context, testIndex) {
                                    return Container(
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
                                                      .onProcessOrderList[index]
                                                      .selectedTest![testIndex]
                                                      .testImage!),
                                            ),
                                            const Gap(8),
                                            Text(
                                              ordersProvider
                                                  .onProcessOrderList[index]
                                                  .selectedTest![testIndex]
                                                  .testName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Gap(10),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sayed Ali MH',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: BColors.black),
                                            ),
                                            const Gap(5),
                                            RowTwoTextWidget(
                                                text1: 'Age',
                                                text2: ordersProvider
                                                        .onProcessOrderList[
                                                            index]
                                                        .userDetails!
                                                        .userAge ??
                                                    'Not Provided',
                                                gap: 48),
                                            const Gap(5),
                                            RowTwoTextWidget(
                                                text1: 'Gender',
                                                text2: ordersProvider
                                                        .onProcessOrderList[
                                                            index]
                                                        .userDetails!
                                                        .gender ??
                                                    'Not Provided',
                                                gap: 25),
                                            const Gap(5),
                                            RowTwoTextWidget(
                                                text1: 'Phone No',
                                                text2: ordersProvider
                                                        .onProcessOrderList[
                                                            index]
                                                        .userDetails!
                                                        .phoneNo ??
                                                    'Not Provided',
                                                gap: 12),
                                          ],
                                        ),
                                        Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: BColors.white,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    BIcon.uploadPng,
                                                    scale: 5,
                                                  ),
                                                  Text(
                                                    'Upload Result',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                          fontSize: 12,
                                                          color: BColors.black,
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(8),
                                ordersProvider.onProcessOrderList[index]
                                            .testMode ==
                                        'Lab'
                                    ? const Gap(0)
                                    : OnProcessAddress(index: index),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Test Mode : ${ordersProvider.onProcessOrderList[index].testMode}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 15),
                                        ),
                                        const Gap(5),
                                        Text(
                                          'Total Amount : ₹${ordersProvider.onProcessOrderList[index].finalAmount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 15),
                                        ),
                                        const Gap(5),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Payment Mode : ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 15),
                                            children: [
                                              TextSpan(
                                                text: 'COD',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color: BColors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(5),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Payment Status : ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontSize: 15),
                                            children: [
                                              TextSpan(
                                                text: ordersProvider
                                                            .onProcessOrderList[
                                                                index]
                                                            .paymentStatus ==
                                                        0
                                                    ? 'Pending'
                                                    : ordersProvider
                                                                .onProcessOrderList[
                                                                    index]
                                                                .paymentStatus ==
                                                            1
                                                        ? 'Completed'
                                                        : 'Cancelled',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontSize: 15,
                                                      color: ordersProvider
                                                                  .onProcessOrderList[
                                                                      index]
                                                                  .paymentStatus ==
                                                              0
                                                          ? BColors.pendingColor
                                                          : ordersProvider
                                                                      .onProcessOrderList[
                                                                          index]
                                                                      .paymentStatus ==
                                                                  1
                                                              ? BColors.green
                                                              : BColors.red,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                ButtonWidget(
                                  buttonHeight: 42,
                                  buttonWidth: double.infinity,
                                  buttonColor: Colors.green,
                                  buttonWidget: Text(
                                    'Complete Order',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
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
