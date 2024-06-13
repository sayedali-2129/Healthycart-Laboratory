// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/confirm_alertbox/confirm_delete_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/button_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_indicater.dart';
import 'package:healthy_cart_laboratory/core/custom/no_data_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/toast/toast.dart';
import 'package:healthy_cart_laboratory/features/authenthication/application/authenication_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/date_and_time_picker.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/reject_popup.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/selected_test_list.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/presentation/widgets/user_address_card.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:intl/intl.dart';
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
          if (ordersProvider.isLoading && ordersProvider.newOrderList.isEmpty)
            const SliverFillRemaining(child: Center(child: LoadingIndicater()))
          else if (ordersProvider.newOrderList.isEmpty)
            const SliverFillRemaining(
                child: NoDataImageWidget(text: 'No New Requests Found!'))
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.builder(
                itemCount: ordersProvider.newOrderList.length,
                itemBuilder: (context, index) {
                  final orderDate =
                      ordersProvider.newOrderList[index].orderAt!.toDate();
                  final formattedDate =
                      DateFormat('dd/MM/yyyy').format(orderDate);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: BColors.darkblue),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          ordersProvider
                                              .newOrderList[index].id!,
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
                              /* -------------------------------- TEST LIST ------------------------------- */
                              ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const Gap(8),
                                  itemCount: ordersProvider
                                      .newOrderList[index].selectedTest!.length,
                                  itemBuilder: (context, testIndex) {
                                    return SelectedTestsCard(
                                      image: ordersProvider.newOrderList[index]
                                          .selectedTest![testIndex].testImage!,
                                      testName: ordersProvider
                                          .newOrderList[index]
                                          .selectedTest![testIndex]
                                          .testName!,
                                    );
                                  }),
                              const Gap(8),
                              /* ------------------------------ USER DETAILS ------------------------------ */
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
                                onTap: () async {
                                  await ordersProvider.lauchDialer(
                                      phoneNumber: ordersProvider
                                          .newOrderList[index]
                                          .userDetails!
                                          .phoneNo!);
                                },
                              ),
                              const Gap(8),
                              /* --------------------------------- ADDRESS -------------------------------- */
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
                                  /* ------------------------------ TEST DETAILS ------------------------------ */
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
                                      ordersProvider.newOrderList[index]
                                                  .testMode ==
                                              'Lab'
                                          ? const Gap(0)
                                          : DetailsTexts(
                                              leftText: 'Door Step Charge',
                                              rightText: (ordersProvider
                                                              .newOrderList[
                                                                  index]
                                                              .doorStepCharge !=
                                                          null &&
                                                      ordersProvider
                                                              .newOrderList[
                                                                  index]
                                                              .doorStepCharge !=
                                                          0)
                                                  ? '₹${ordersProvider.newOrderList[index].doorStepCharge!}'
                                                  : '0'),
                                      const Gap(5),
                                      DetailsTexts(
                                        leftText: 'Total Amount',
                                        rightText: ordersProvider
                                                    .newOrderList[index]
                                                    .finalAmount ==
                                                0
                                            ? '₹${ordersProvider.newOrderList[index].totalAmount!}'
                                            : '₹${ordersProvider.newOrderList[index].finalAmount!}',
                                        leftTextSize: 14,
                                        leftTextWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(12),

                              /* --------------------------- TIME SLOT SELECTION -------------------------- */

                              if (ordersProvider.newOrderList[index].testMode ==
                                  'Home')
                                ordersProvider.newOrderList[index].timeSlot ==
                                        null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ButtonWidget(
                                            buttonHeight: 42,
                                            buttonWidth: 180,
                                            buttonColor: BColors.darkblue,
                                            buttonWidget: const Text(
                                              'Select Date & Time',
                                              style: TextStyle(
                                                  color: BColors.white,
                                                  fontSize: 12),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DateAndTimePick(
                                                        onSave: () {
                                                          if (ordersProvider.selectedTimeSlot1 != null &&
                                                              ordersProvider
                                                                      .selectedTimeSlot2 !=
                                                                  null &&
                                                              ordersProvider
                                                                  .dateController
                                                                  .text
                                                                  .isNotEmpty) {
                                                            ordersProvider.setTimeSlot(
                                                                orderId: ordersProvider
                                                                    .newOrderList[
                                                                        index]
                                                                    .id!,
                                                                dateAndTime:
                                                                    '${ordersProvider.dateController.text} - ${ordersProvider.selectedTimeSlot1} - ${ordersProvider.selectedTimeSlot2}');
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            CustomToast.errorToast(
                                                                text:
                                                                    'Please select date and time');
                                                          }
                                                        },
                                                      ));
                                            },
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      ordersProvider
                                                              .newOrderList[
                                                                  index]
                                                              .timeSlot ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const Gap(8),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                DateAndTimePick(
                                                                  onSave: () {
                                                                    if (ordersProvider.selectedTimeSlot1 != null &&
                                                                        ordersProvider.selectedTimeSlot2 !=
                                                                            null &&
                                                                        ordersProvider
                                                                            .dateController
                                                                            .text
                                                                            .isNotEmpty) {
                                                                      ordersProvider.setTimeSlot(
                                                                          orderId: ordersProvider
                                                                              .newOrderList[
                                                                                  index]
                                                                              .id!,
                                                                          dateAndTime:
                                                                              '${ordersProvider.dateController.text} - ${ordersProvider.selectedTimeSlot1} - ${ordersProvider.selectedTimeSlot2}');
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      CustomToast.errorToast(
                                                                          text:
                                                                              'Please select date and time');
                                                                    }
                                                                  },
                                                                ));
                                                      },
                                                      child: const Icon(
                                                        Icons.edit_outlined,
                                                        color: BColors.black,
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                              /* -------------------------------------------------------------------------- */
                              const Gap(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /* ------------------------------ REJECT BUTTON ----------------------------- */
                                  SizedBox(
                                    height: 40,
                                    width: 136,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              RejectionReasonPopup(
                                            reasonController: ordersProvider
                                                .rejectionController,
                                            formKey:
                                                ordersProvider.rejectionFormKey,
                                            onConfirm: () {
                                              if (!ordersProvider
                                                  .rejectionFormKey
                                                  .currentState!
                                                  .validate()) {
                                                ordersProvider.rejectionFormKey
                                                    .currentState!
                                                    .validate();
                                              } else {
                                                ordersProvider
                                                    .updateOrderStatus(
                                                  orderId: ordersProvider
                                                      .newOrderList[index].id!,
                                                  orderStatus: 3,
                                                  rejectReason: ordersProvider
                                                      .rejectionController.text,
                                                );
                                                ordersProvider
                                                    .rejectionController
                                                    .clear();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              BColors.buttonRedShade,
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
                                  /* ------------------------------ ACCEPT BUTTON ----------------------------- */
                                  SizedBox(
                                    height: 40,
                                    width: 136,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (ordersProvider.newOrderList[index]
                                                    .testMode ==
                                                'Home' &&
                                            ordersProvider.newOrderList[index]
                                                    .timeSlot ==
                                                null) {
                                          CustomToast.errorToast(
                                              text:
                                                  'Please select date and time');
                                          return;
                                        }
                                        ConfirmAlertBoxWidget
                                            .showAlertConfirmBox(
                                                context: context,
                                                confirmButtonTap: () {
                                                  ordersProvider
                                                      .updateOrderStatus(
                                                          currentAmount:
                                                              ordersProvider
                                                                  .newOrderList[
                                                                      index]
                                                                  .totalAmount!,
                                                          finalAmount:
                                                              ordersProvider
                                                                  .newOrderList[
                                                                      index]
                                                                  .finalAmount!,
                                                          orderId:
                                                              ordersProvider
                                                                  .newOrderList[
                                                                      index]
                                                                  .id!,
                                                          orderStatus: 1);
                                                },
                                                titleText: 'Confirm',
                                                subText:
                                                    'Are you sure you want to accept this order?');
                                      },
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
    this.onTap,
  });
  final String userName;
  final String age;
  final String phoneNumber;
  final String gender;
  final void Function()? onTap;

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
                      const Gap(8),
                      RowTwoTextWidget(text1: 'Gender', text2: gender, gap: 24),
                      const Gap(8),
                      RowTwoTextWidget(
                          text1: 'Phone No', text2: phoneNumber, gap: 8),
                    ],
                  ),
                ),
                const Gap(12),
                // PhysicalModel(
                //     elevation: 2,
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     child: SizedBox(
                //         width: 40,
                //         height: 40,
                //         child: Center(
                //             child: IconButton(
                //                 onPressed: () {},
                //                 icon: const Icon(
                //                   Icons.location_on_sharp,
                //                   size: 24,
                //                   color: Colors.blue,
                //                 )))),
                //                 ),
                // const Gap(8),
                PhysicalModel(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: IconButton(
                                onPressed: onTap,
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
