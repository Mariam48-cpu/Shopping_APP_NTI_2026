import 'package:flutter/material.dart';
import 'package:shopping_app/feature/onboarding/widget/custom_animated_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static String routeName = 'OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingData> onboardingList = dataOnboarding();
  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index > 0)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,

                          color: Color(0xff121212),
                        ),
                        onPressed: () {
                          controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    Spacer(),

                    if (index < onboardingList.length - 1)
                      TextButton(
                        onPressed: () {
                          controller.animateToPage(
                            onboardingList.length - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xff121212),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 315,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemCount: onboardingList.length,
                  itemBuilder: (context, index) {
                    return CustomAnimatedWidget(
                      index: index,
                      delay: index,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          onboardingList[index].image,
                          fit: BoxFit.cover,
                          width: 343,
                          height: 315,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 14),
              SmoothPageIndicator(
                controller: controller,
                count: onboardingList.length,
                effect: SlideEffect(
                  spacing: 8.0,
                  radius: 5.0,
                  dotWidth: 15.0,
                  dotHeight: 15.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Color(0xff212121),
                ),
              ),
              SizedBox(height: 40),

              CustomAnimatedWidget(
                index: index,
                delay: (index + 1) * 100,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 69),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        onboardingList[index].title,
                        style: TextStyle(
                          color: Color(0xff1f1f1f),
                          fontWeight: .w700,
                          fontSize: 22,
                        ),
                        textAlign: .center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        onboardingList[index].description,
                        style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontWeight: .w400,
                          fontSize: 18,
                        ),
                        textAlign: .center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 56),

              MaterialButton(
                minWidth: double.infinity,
                height: 48,
                onPressed: () {
                  if (index < onboardingList.length - 1) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,

                    );

                  } else {
                    if (!mounted) return;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.helloScreen,
                          (route) => false,
                    );
                  }
                },
                color: Color(0xFFFF9900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  index < onboardingList.length - 1 ? 'Next' : 'Get started',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}