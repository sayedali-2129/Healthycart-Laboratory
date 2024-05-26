import 'package:flutter/material.dart';

class CircularAddImageWidget extends StatelessWidget {
  const CircularAddImageWidget({
    super.key,
    required this.addTap,
    required this.iconSize,
    required this.height,
    required this.width,
    required this.radius,
  });
  final VoidCallback addTap;
  final double iconSize;
  final double height;
  final double width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: addTap,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: const Center(
            child: (Icon(
              Icons.add_circle_outline_rounded,
              size: 48,
            )),
          ),
        ));
  }
}
