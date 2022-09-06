import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/already_have_an_acount_check.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../login/login_page.dart';
import '../../signup/components/or_divider.dart';
import '../../signup/components/social_icon.dart';

import 'back_ground.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {},
              icon: Icons.person,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: 'SIGNUP',
              onPressed: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAcountCheck(
              login: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
