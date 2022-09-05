import 'package:flutter/material.dart';

class CenterWidgetClipper extends CustomClipper<Path> {
  final Path path;

  const CenterWidgetClipper({required this.path});

  @override
  Path getClip(Size size) {
/*
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// function to get prime numbers
