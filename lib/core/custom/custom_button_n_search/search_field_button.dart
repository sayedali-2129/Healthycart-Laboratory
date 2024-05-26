import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_laboratory/core/custom/text_formfield/textformfield.dart';
import 'package:healthy_cart_laboratory/utils/constants/colors/colors.dart';

class SearchTextFieldButton extends StatelessWidget {
  const SearchTextFieldButton({
    super.key,
    required this.text,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.searchIcon,
    required this.controller,
  });
  final String text;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final TextEditingController controller;
  final bool? searchIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 3,
              child: TextfieldWidget(
                  controller: controller,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                  hintText: text,
                  style: Theme.of(context).textTheme.labelLarge!),
            ),
          ),
          const Gap(4),
          (searchIcon == true)
              ? GestureDetector(
                  onTap: onTap,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 56,
                      decoration: BoxDecoration(
                        color: BColors.mainlightColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: BColors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
