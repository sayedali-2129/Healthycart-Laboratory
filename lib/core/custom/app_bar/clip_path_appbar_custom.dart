import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 12); // Start at the bottom-left
    path.quadraticBezierTo(0, size.height, 12, size.height); // Bottom-left curve
    path.lineTo(size.width - 12, size.height); // Straight line before bottom-right curve
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 12); // Bottom-right curve
    path.lineTo(size.width, 0); // End at the top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
