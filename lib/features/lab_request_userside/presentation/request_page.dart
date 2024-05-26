import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthy_cart_laboratory/features/lab_request_userside/application/provider/request_doctor_provider.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestDoctorProvider>(builder: (context, state, _) {
      return CustomScrollView(
        slivers: [
          const CustomCurveAppBarWidget(),
          HorizontalTabBarWidget(
            state: state,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.builder(
              itemCount: 4,
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
                                    child: Text('Order No-${index + 1}',
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
                              itemCount: 3,
                              itemBuilder: (context, index) => Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ///// IMAGE CIRCLE /////
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.amber),
                                      ),
                                      const Gap(8),
                                      Text(
                                        'Blood Test',
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
                              ),
                            ),
                            const Gap(8),
                            const UserDetailsContainer(),
                            const Gap(8),
                            const DetailsTexts(
                                leftText: 'Test Mode', rightText: 'Door Step'),
                            const Gap(5),
                            const DetailsTexts(
                                leftText: 'Payment',
                                rightText: 'Cash On Delivery'),
                            const Gap(5),
                            const DetailsTexts(
                                leftText: 'Test Amount', rightText: '₹950'),
                            const Gap(5),
                            const DetailsTexts(
                                leftText: 'Door Step Charge', rightText: '₹50'),
                            const Gap(5),
                            const DetailsTexts(
                              leftText: 'Total Amount',
                              rightText: '₹1000',
                              leftTextSize: 14,
                              leftTextWeight: FontWeight.w600,
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
          )
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
  });

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
              'Jassel Ck',
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
                const SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowTwoTextWidget(text1: 'Age', text2: '25', gap: 48),
                      Gap(8),
                      RowTwoTextWidget(text1: 'Gender', text2: 'Male', gap: 24),
                      Gap(8),
                      RowTwoTextWidget(
                          text1: 'Phone No', text2: '+919569845632', gap: 8),
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

class HorizontalTabBarWidget extends StatelessWidget {
  const HorizontalTabBarWidget({
    super.key,
    required this.state,
  });
  final RequestDoctorProvider state;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      shadowColor: Colors.grey[400],
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white70,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: SizedBox(
                  height: 40,
                  width: 136,
                  child: ElevatedButton(
                    onPressed: () {
                      state.changeTabINdex(index: 0);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: (state.tabIndex == 0)
                            ? const Color(0xFF11334E)
                            : Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius: BorderRadius.circular(14))),
                    child: Text('New Request',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: (state.tabIndex == 0)
                                      ? Colors.white
                                      : Colors.black,
                                )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: SizedBox(
                  height: 40,
                  width: 136,
                  child: ElevatedButton(
                    onPressed: () {
                      state.changeTabINdex(index: 1);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: (state.tabIndex == 1)
                            ? const Color(0xFF11334E)
                            : Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius: BorderRadius.circular(14))),
                    child: Text('On Process',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: (state.tabIndex == 1)
                                      ? Colors.white
                                      : Colors.black,
                                )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 40,
                  width: 136,
                  child: ElevatedButton(
                    onPressed: () {
                      state.changeTabINdex(index: 2);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: (state.tabIndex == 2)
                            ? const Color(0xFF11334E)
                            : Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius: BorderRadius.circular(14))),
                    child: Text('Visited',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: (state.tabIndex == 2)
                                      ? Colors.white
                                      : Colors.black,
                                )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
