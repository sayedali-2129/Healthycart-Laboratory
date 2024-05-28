import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/sliver_appbar.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/presentation/admin_transactions.dart';
import 'package:healthy_cart_laboratory/features/laboratory_profile/presentation/user_transactions.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverCustomAppbar(
              title: 'Payments',
              onBackTap: () {
                Navigator.pop(context);
              },
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  color: BColors.white,
                  child: TabBar(
                      indicatorColor: BColors.white,
                      dividerColor: BColors.white,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? BColors.darkblue
                                    : BColors.mainlightColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: Text(
                              'User Transaction',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: selectedIndex == 0
                                          ? BColors.white
                                          : BColors.darkblue.withOpacity(0.5)),
                            )),
                          ),
                        ),
                        Container(
                          height: 42,
                          decoration: BoxDecoration(
                              color: selectedIndex == 1
                                  ? BColors.darkblue
                                  : BColors.mainlightColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            'Admin Transaction',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: selectedIndex == 1
                                        ? BColors.white
                                        : BColors.darkblue.withOpacity(0.5)),
                          )),
                        )
                      ]),
                ),
              ),
            ),
            const SliverFillRemaining(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [UserPayment(), AdminPayment()]),
            )
          ],
        ),
      ),
    );
  }
}
