import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_indicater.dart';
import 'package:healthy_cart_laboratory/core/custom/no_data_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/pdf_viewer/pdf_viewer.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/new_request.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  final scrollController = ScrollController();

  @override
  initState() {
    final authProvider = context.read<AuthenticationProvider>();
    final ordersProvider = context.read<LabOrdersProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ordersProvider
          ..cleatDataCompleted()
          ..getCompletedOrders(
              labId: authProvider.labFetchlDataFetched!.id!, limit: 5);
      },
    );
    ordersProvider.completeInit(
        scrollController, authProvider.labFetchlDataFetched!.id!, 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, ordersProvider, _) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          if (ordersProvider.isLoading == true &&
              ordersProvider.completedOrderList.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: LoadingIndicater(),
              ),
            )
          else if (ordersProvider.completedOrderList.isEmpty)
            const SliverFillRemaining(
              child: NoDataImageWidget(text: 'No Completed Orders Found!'),
            )
          else
            SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                    separatorBuilder: (context, index) => const Gap(10),
                    itemCount: ordersProvider.completedOrderList.length,
                    itemBuilder: (context, index) {
                      final completedOrders =
                          ordersProvider.completedOrderList[index];
                      final acceptedAt = completedOrders.completedAt!.toDate();

                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(acceptedAt);

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
                                      child: Text(completedOrders.id!,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: BColors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  const Gap(4),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          completedOrders
                                                      .selectedTest!.length ==
                                                  1
                                              ? Text(
                                                  completedOrders.selectedTest!
                                                      .first.testName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge)
                                              : Text(
                                                  '${completedOrders.selectedTest!.first.testName!} & ${completedOrders.selectedTest!.length - 1} More',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                          const Gap(5),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewPdfScreen(
                                                            pdfUrl:
                                                                completedOrders
                                                                    .resultUrl!,
                                                            title:
                                                                completedOrders
                                                                    .userDetails!
                                                                    .userName!,
                                                            headingColor:
                                                                BColors.black,
                                                          )));
                                            },
                                            child: const Text(
                                              'View Result',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                  color: BColors.darkblue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              /* ------------------------------ USER DETAILS ------------------------------ */
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                  text2: completedOrders
                                                          .userDetails!
                                                          .userAge ??
                                                      'Not Provided',
                                                  gap: 48),
                                              const Gap(5),
                                              RowTwoTextWidget(
                                                  text1: 'Gender',
                                                  text2: completedOrders
                                                          .userDetails!
                                                          .gender ??
                                                      'Not Provided',
                                                  gap: 25),
                                              const Gap(5),
                                              RowTwoTextWidget(
                                                  text1: 'Phone No',
                                                  text2: completedOrders
                                                          .userDetails!
                                                          .phoneNo ??
                                                      'Not Provided',
                                                  gap: 12),
                                            ],
                                          ),
                                          const Gap(10),
                                          /* ------------------------------ PHONE DIALER ------------------------------ */
                                          PhysicalModel(
                                              elevation: 2,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Center(
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            await ordersProvider
                                                                .lauchDialer(
                                                                    phoneNumber:
                                                                        completedOrders
                                                                            .userDetails!
                                                                            .phoneNo!);
                                                          },
                                                          icon: const Icon(
                                                              Icons.phone,
                                                              size: 24,
                                                              color: Colors
                                                                  .blue))))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          SliverToBoxAdapter(
              child: (ordersProvider.isLoading == true &&
                      ordersProvider.completedOrderList.isNotEmpty)
                  ? const Center(child: LoadingIndicater())
                  : const Gap(0)),
        ],
      );
    });
  }
}
