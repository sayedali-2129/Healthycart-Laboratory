// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthy_cart_laboratory/core/custom/confirm_alertbox/confirm_delete_widget.dart';
import 'package:healthy_cart_laboratory/core/custom/custom_button_n_search/common_button.dart';
import 'package:healthy_cart_laboratory/core/custom/lottie/loading_indicater.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/application/provider/test_provider.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/add_test_bottomsheet.dart';
import 'package:healthy_cart_laboratory/features/tests_screen/presentation/widgets/tests_lists_container.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final labId = FirebaseAuth.instance.currentUser!.uid;
        final testProvider = context.read<TestProvider>();
        testProvider.getTests(labId: labId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labId = FirebaseAuth.instance.currentUser!.uid;
    return Consumer<TestProvider>(builder: (context, testProvider, _) {
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
                        useSafeArea: false,
                        backgroundColor: BColors.white,
                        showDragHandle: true,
                        enableDrag: true,
                        context: context,
                        builder: (context) => TestAddBottomSheet(
                              labId: labId,
                              onImageTap: () {
                                testProvider.pickLabImage();
                              },
                            ));
                  },
                  text: '+ Add New',
                  buttonColor: BColors.darkblue,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: BColors.white)),
            )),
            if (testProvider.testList.isEmpty &&
                testProvider.labFetchLoading == true)
              const SliverFillRemaining(
                child: Center(
                  child: LoadingIndicater(),
                ),
              )
            else if (testProvider.testList.isEmpty)
              const SliverFillRemaining(
                  child: Center(
                child: Text('No Tests Found!'),
              ))
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const Gap(5),
                  itemCount: testProvider.testList.length,
                  itemBuilder: (context, index) => TestsListContainer(
                    onEdit: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: false,
                          backgroundColor: BColors.white,
                          showDragHandle: true,
                          enableDrag: true,
                          context: context,
                          builder: (context) => TestAddBottomSheet(
                                index: index,
                                editData: testProvider.testList[index],
                                labId: labId,
                                onImageTap: () {
                                  testProvider.pickLabImage();
                                },
                              ));
                    },
                    onDelete: () {
                      ConfirmAlertBoxWidget.showAlertConfirmBox(
                          context: context,
                          confirmButtonTap: () {
                            testProvider.deleteTest(
                                testId: testProvider.testList[index].id!,
                                index: index);
                          },
                          titleText: 'Confirm Delete',
                          subText: 'Are you sure want to delete the test?');
                    },
                    index: index,
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}
