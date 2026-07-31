import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/custom_button.dart';
import 'package:shopping_app/core/routes/app_routes.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({super.key});

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 137,
          children: [
            Column(
              spacing: 24,
              children: [
                Image.asset("assets/images/hello_image.png"),
                Image.asset("assets/images/hello_text.png"),
              ],
            ),

            Column(
              spacing: 16,
              children: [
                CustomButton(
                  txt: "Sign up",
                  width: 343,
                  height: 48,
                  color: Color(0xffFF9900),
                  fun: () => Navigator.pushNamed(context, Routes.signUpScreen),
                  borderColor: Color(0xffFFB700),
                  txtColor: Color(0xffFFFFFF),
                ),
                CustomButton(
                  txt: "Login",
                  width: 343,
                  height: 48,
                  color: Color(0xffffffff),
                  fun: () => Navigator.pushNamed(context, Routes.logInScreen),
                  borderColor: Color(0xffFF9900),
                  txtColor: Color(0xffFF9900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
