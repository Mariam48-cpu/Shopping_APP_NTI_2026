import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffff9900).withOpacity(.08),
                ),
              ),
            ).animate().scale(duration: 1200.ms, curve: Curves.easeOut),

            Positioned(
              bottom: -80,
              left: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(.04),
                ),
              ),
            ),

            SingleChildScrollView(
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
                          Image.asset("assets/images/hello_image.png")
                              .animate()
                              .fade(duration: 700.ms)
                              .scale(
                                begin: const Offset(.7, .7),
                                duration: 700.ms,
                                curve: Curves.easeOutBack,
                              ),

                          const SizedBox(height: 24),

                          Image.asset("assets/images/hello_text.png")
                              .animate()
                              .fade(delay: 300.ms, duration: 600.ms)
                              .slideY(begin: .3, duration: 600.ms),
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
                                txtColor: Colors.white,
                                fun: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.signUpScreen,
                                  );
                                },
                              )
                              .animate()
                              .slideY(
                                begin: 1,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              )
                              .fade(),

                          const SizedBox(height: 16),

                          CustomButton(
                                txt: "Login",
                                width: double.infinity,
                                height: 48,
                                color: Colors.white,
                                borderColor: const Color(0xffFF9900),
                                txtColor: const Color(0xffFF9900),
                                fun: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.logInScreen,
                                  );
                                },
                              )
                              .animate()
                              .slideY(
                                begin: 1,
                                delay: 150.ms,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              )
                              .fade(),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
