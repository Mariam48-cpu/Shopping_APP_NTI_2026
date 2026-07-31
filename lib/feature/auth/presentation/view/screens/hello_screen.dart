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
      backgroundColor: const Color(0xffEBEBEB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const Spacer(),

                  Column(
                    children: [
                      Image.asset("assets/images/hello_image.png"),
                      const SizedBox(height: 24),
                      Image.asset("assets/images/hello_text.png"),
                    ],
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      CustomButton(
                        txt: "Sign up",
                        width: double.infinity,
                        height: 48,
                        color: const Color(0xffFF9900),
                        borderColor: const Color(0xffFFB700),
                        txtColor: const Color(0xffFFFFFF),
                        fun: () =>
                            Navigator.pushNamed(context, Routes.signUpScreen),
                      ),

                      const SizedBox(height: 16),

                      CustomButton(
                        txt: "Login",
                        width: double.infinity,
                        height: 48,
                        color: const Color(0xffffffff),
                        borderColor: const Color(0xffFF9900),
                        txtColor: const Color(0xffFF9900),
                        fun: () =>
                            Navigator.pushNamed(context, Routes.logInScreen),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
