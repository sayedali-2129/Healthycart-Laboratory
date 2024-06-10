// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/button_widget.dart';
import 'package:healthy_cart_laboratory/core/general/validator.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/lab_orders_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<LabOrdersProvider>(builder: (context, orderProvider, _) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Address :-',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: BColors.black),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: BColors.white,
                      title: Text(
                        'Set Door Step Charge',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      content: Form(
                        key: orderProvider.deliveryChargeKey,
                        child: TextFormField(
                          validator: BValidator.validate,
                          controller: orderProvider.deliveryChargeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Door Step Charge',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        ButtonWidget(
                            buttonHeight: 40,
                            buttonWidth: 100,
                            buttonColor: BColors.darkblue,
                            buttonWidget: const Text('Save',
                                style: TextStyle(
                                    color: BColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
                              if (!orderProvider.deliveryChargeKey.currentState!
                                  .validate()) {
                                orderProvider.deliveryChargeKey.currentState!
                                    .validate();
                              } else {
                                orderProvider.updateDoorStepCharge(
                                    orderId:
                                        orderProvider.newOrderList[index].id!);
                                orderProvider.deliveryChargeController.clear();
                                Navigator.pop(context);
                              }
                            })
                      ],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'Set Door Step Charge',
                      style: TextStyle(
                          color: BColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
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
                                  .newOrderList[index].userAddress!.name!,
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
                                    orderProvider.newOrderList[index]
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
                          '${orderProvider.newOrderList[index].userAddress!.address ?? 'Address'} ${orderProvider.newOrderList[index].userAddress!.landmark ?? 'Address'} - ${orderProvider.newOrderList[index].userAddress!.pincode ?? 'Address'}',
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
                          .newOrderList[index].userAddress!.phoneNumber!,
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
