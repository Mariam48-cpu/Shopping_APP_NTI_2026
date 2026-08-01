import 'package:flutter/material.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/feature/onboarding/widget/custom_animated_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String routeName = 'OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingData> onboardingList = dataOnboarding();

  final PageController controller = PageController();

  int index = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> finishOnBoarding() async {
    await serviceLocator<SecureStorageHelper>().saveSecure(
      key: 'is_first_time',
      value: 'false',
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.helloScreen,
      (_) => false,
    );
  }

  Future<void> skipOnBoarding() async {
    await serviceLocator<SecureStorageHelper>().saveSecure(
      key: 'is_first_time',
      value: 'false',
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.logInScreen,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  if (index > 0)
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),

                  const Spacer(),

                  if (index < onboardingList.length - 1)
                    TextButton(
                      onPressed: skipOnBoarding,
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: controller,
                  itemCount: onboardingList.length,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    return CustomAnimatedWidget(
                      index: index,
                      delay: pageIndex * 120,
                      child: Hero(
                        tag: onboardingList[pageIndex].image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(
                            onboardingList[pageIndex].image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              SmoothPageIndicator(
                controller: controller,
                count: onboardingList.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: const Color(0xffFF9900),
                  dotColor: Colors.grey.shade300,
                  dotHeight: 9,
                  dotWidth: 9,
                  expansionFactor: 3.5,
                  spacing: 8,
                ),
              ),

              const SizedBox(height: 42),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: Container(
                  key: ValueKey(index),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        onboardingList[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1F1F1F),
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        onboardingList[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Color(0xff777777),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffFFB300), Color(0xffFF9800)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffFF9800).withOpacity(.30),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    splashColor: Colors.white24,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (index < onboardingList.length - 1) {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 450),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        await finishOnBoarding();
                      }
                    },
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(.20, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Row(
                          key: ValueKey(index),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              index == onboardingList.length - 1
                                  ? "Get Started"
                                  : "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .3,
                              ),
                            ),

                            const SizedBox(width: 10),

                            AnimatedRotation(
                              turns: index == onboardingList.length - 1
                                  ? .12
                                  : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                index == onboardingList.length - 1
                                    ? Icons.rocket_launch_rounded
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
