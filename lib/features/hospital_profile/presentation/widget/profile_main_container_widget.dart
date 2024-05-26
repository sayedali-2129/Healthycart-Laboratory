import 'package:flutter/material.dart';

class ProfileMainContainer extends StatelessWidget {
  const ProfileMainContainer({
    super.key,
    required this.text, required this.sideChild,
  });

  final String text;
  final Widget sideChild;
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: Theme.of(context).textTheme.labelLarge!),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: sideChild
            )
          ],
        ),
      ),
    );
  }
}