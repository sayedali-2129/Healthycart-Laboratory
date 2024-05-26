import 'package:flutter/material.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class SliverCustomAppbar extends StatelessWidget {
  const SliverCustomAppbar({
    super.key,
    required this.title,
    required this.onBackTap,
  });
  final String title;
  final VoidCallback onBackTap;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: -6,
      pinned: true,
      forceElevated: true,
      toolbarHeight: 80,
      leading: IconButton(
          onPressed: onBackTap, icon: const Icon(Icons.arrow_back_ios)),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: BColors.darkblue, fontWeight: FontWeight.w700)),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        background: Container(
          decoration: BoxDecoration(
              color: BColors.mainlightColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
        ),
      ),
    );
  }
}
