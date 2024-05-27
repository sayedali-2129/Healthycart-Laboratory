import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/sliver_appbar.dart';
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
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: BColors.darkblue,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: BColors.darkblue,
                                borderRadius: BorderRadius.circular(8)))
                      ]),
                ),
              ),
            ),
            const SliverFillRemaining(
              child: TabBarView(children: [UserPayment(), AdminPayment()]),
            )
          ],
        ),
      ),
    );
  }
}

class UserPayment extends StatelessWidget {
  const UserPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User'),
      ),
    );
  }
}

class AdminPayment extends StatelessWidget {
  const AdminPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Admin'),
      ),
    );
  }
}
