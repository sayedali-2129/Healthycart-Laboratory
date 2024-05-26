import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Divider(
            thickness: 1,
            indent: 60,
            endIndent: 5,
            color: Colors.grey,
          ),
        ),
        Text(text,
            style: Theme.of(context).textTheme.labelSmall),
        const Flexible(
          child: Divider(
            thickness: 1,
            indent: 5,
            endIndent: 60,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
