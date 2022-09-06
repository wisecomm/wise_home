import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('images/signup_top.png', width: size.width * 0.35),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child:
              Image.asset('images/main_bottom.png', width: size.width * 0.25),
        ),
        child,
      ],
    );
  }
}
