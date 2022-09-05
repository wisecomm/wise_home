import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Positioned(top: -160, left: -30, child: topWidget(screenSize.width)),
        Positioned(top: -100, left: -40, child: bottomWidget(screenSize.width)),
        bottomWidget(screenSize.width)
      ],
    ));
  }

  Container bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [Color(0xDB4BEBCC), Color(0x005CDBCF)],
        ),
      ),
    );
  }

  Transform topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 100,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [Color(0x007CBFCF), Color(0xB316BFC4)],
          ),
        ),
      ),
    );
  }
}
