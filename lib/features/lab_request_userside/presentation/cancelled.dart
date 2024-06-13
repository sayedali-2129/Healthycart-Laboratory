import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_indicater.dart';
import 'package:healthy_cart_laboratory/core/custom/no_data_widget.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/new_request.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/selected_test_list.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({super.key});

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final authProvider = context.read<AuthenticationProvider>();
    final ordersProvider = context.read<LabOrdersProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ordersProvider
          ..clearDataRejected()
          ..getRejectedOrders(labId: authProvider.labFetchlDataFetched!.id!);
      },
    );
    ordersProvider.rejectInit(
        scrollController, authProvider.labFetchlDataFetched!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, ordersProvider, _) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          if (ordersProvider.isLoading == true &&
              ordersProvider.rejectedOrderList.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: LoadingIndicater(),
              ),
            )
          else if (ordersProvider.rejectedOrderList.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: NoDataImageWidget(text: 'No Cancelled Orders Found!'),
              ),
            )
          else
            SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const Gap(5),
                  itemCount: ordersProvider.rejectedOrderList.length,
                  itemBuilder: (context, index) {
                    final rejectedOrders =
                        ordersProvider.rejectedOrderList[index];
                    final rejectedAt = rejectedOrders.rejectedAt!.toDate();

                    final formattedDate =
                        DateFormat('dd/MM/yyyy').format(rejectedAt);

                    return PhysicalModel(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: BColors.darkblue),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(rejectedOrders.id!,
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
                                    const Gap(5),
                                itemCount: rejectedOrders.selectedTest!.length,
                                itemBuilder: (context, testIndex) =>
                                    SelectedTestsCard(
                                        image: rejectedOrders
                                            .selectedTest![testIndex]
                                            .testImage!,
                                        testName: rejectedOrders
                                            .selectedTest![testIndex]
                                            .testName!),
                              ),
                              const Gap(8),
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
                                                .copyWith(color: BColors.black),
                                          ),
                                          const Gap(5),
                                          RowTwoTextWidget(
                                              text1: 'Age',
                                              text2: rejectedOrders
                                                      .userDetails!.userAge ??
                                                  'Not Provided',
                                              gap: 48),
                                          const Gap(5),
                                          RowTwoTextWidget(
                                              text1: 'Gender',
                                              text2: rejectedOrders
                                                      .userDetails!.gender ??
                                                  'Not Provided',
                                              gap: 25),
                                          const Gap(5),
                                          RowTwoTextWidget(
                                              text1: 'Phone No',
                                              text2: rejectedOrders
                                                      .userDetails!.phoneNo ??
                                                  'Not Provided',
                                              gap: 12),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text(
                                rejectedOrders.rejectReason == null
                                    ? 'Order Cancelled By User'
                                    : 'Order Rejected By Laboratory',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: BColors.red),
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                        'Reject Reason : ${rejectedOrders.rejectReason ?? 'Not Provided'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: BColors.black,
                                                fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                )),
          SliverToBoxAdapter(
              child: (ordersProvider.isLoading == true &&
                      ordersProvider.rejectedOrderList.isNotEmpty)
                  ? const Center(child: LoadingIndicater())
                  : const Gap(0)),
        ],
      );
    });
  }
}
