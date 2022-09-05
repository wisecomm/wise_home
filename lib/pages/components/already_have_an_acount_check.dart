import 'package:flutter/material.dart';

import '../../constants.dart';

class AlreadyHaveAnAcountCheck extends StatelessWidget {
  final bool login;
  final GestureTapCallback? onTap;

  const AlreadyHaveAnAcountCheck({
    Key? key,
    this.login = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Don\'t hava an Account ? ' : 'Already have an Account ? ',
          style: TextStyle(color: primaryColor),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            login ? 'Sing Up' : 'Sign In',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
