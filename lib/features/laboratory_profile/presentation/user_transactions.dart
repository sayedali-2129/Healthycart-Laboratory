import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_indicater.dart';
import 'package:healthy_cart_laboratory/core/custom/no_data_widget.dart';
import 'package:healthy_cart_laboratory/core/general/cached_network_image.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:healthy_cart_laboratory/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class UserPayment extends StatefulWidget {
  const UserPayment({super.key});

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  final scrollController = ScrollController();
  @override
  void initState() {
    final provider = context.read<LabOrdersProvider>();
    final authProvider = context.read<AuthenticationProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        provider
          ..cleatDataCompleted()
          ..getCompletedOrders(
              labId: authProvider.labFetchlDataFetched!.id!, limit: 20);
      },
    );
    provider.completeInit(
        scrollController, authProvider.labFetchlDataFetched!.id!, 20);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<LabOrdersProvider>(context);

    return Scaffold(
        body: CustomScrollView(
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
            child: NoDataImageWidget(text: 'No Transactiond Found!'),
          )
        else
          SliverPadding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 32),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const Gap(5),
              itemCount: ordersProvider.completedOrderList.length,
              itemBuilder: (context, index) {
                final orders = ordersProvider.completedOrderList[index];
                return Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 50,
                          width: 50,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: orders.userDetails!.image == null
                              ? Image.asset(BImage.userAvatar)
                              : CustomCachedNetworkImage(
                                  image: orders.userDetails!.image!),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                      orders.userDetails!.userName ??
                                          'Not Provided',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ),
                                Text(
                                  orders.paymentMethod ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: BColors.green),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹${orders.finalAmount ?? 0}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        SliverToBoxAdapter(
            child: (ordersProvider.isLoading == true &&
                    ordersProvider.completedOrderList.isNotEmpty)
                ? const Center(child: LoadingIndicater())
                : const Gap(0)),
      ],
    ));
  }
}
