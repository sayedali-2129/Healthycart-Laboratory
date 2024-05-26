import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/add_test_bottomsheet.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/tests_lists_container.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomCurveAppBarWidget(),
          const SliverGap(18),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton(
                width: double.infinity,
                height: 48,
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: BColors.white,
                      showDragHandle: true,
                      enableDrag: true,
                      context: context,
                      builder: (context) => const TestAddBottomSheet());
                },
                text: '+ Add New',
                buttonColor: BColors.darkblue,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: BColors.white)),
          )),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const Gap(5),
              itemCount: 5,
              itemBuilder: (context, index) => const TestsListContainer(),
            ),
          )
        ],
      ),
    );
  }
}
