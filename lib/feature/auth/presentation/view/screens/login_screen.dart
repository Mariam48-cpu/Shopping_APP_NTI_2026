// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopping_app/core/common/widgets/custom_text_field.dart';
// import 'package:shopping_app/core/utils/app_dialogs.dart';
// import 'package:shopping_app/core/utils/app_toast.dart';
// import 'package:shopping_app/feature/auth/presentation/view_model/login/login_cubit.dart';
// import 'package:shopping_app/feature/auth/presentation/view_model/login/login_state.dart';
// import 'package:toastification/toastification.dart';
// import '../../../../../core/di/service_locator.dart';
// import '../../../../../core/routes/app_routes.dart';
// import '../../../../../core/utils/validator.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   static const String routeName = "LoginScreen";

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => serviceLocator<LoginCubit>(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Login",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff1F1F1F),
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: BlocListener<LoginCubit, LoginState>(
//           listener: (BuildContext context, state) {
//             if (state is LoginLoading) {
//               AppDialogs.showLoadingDialog(context);
//             } else if (state is LoginError) {
//               Navigator.of(context, rootNavigator: true).pop();
//               AppToast.showToast(
//                 context: context,
//                 title: "Error",
//                 description: state.message,
//                 type: ToastificationType.error,
//               );
//             } else if (state is LoginSuccess) {
//               // إغلاق الـ Loading Dialog أولاً
//               Navigator.of(context, rootNavigator: true).pop();

//               // 👈 التعديل هنا: التوجيه لـ bottomNavigationScreen بدلاً من homeScreen
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 Routes.bottomNavigationScreen,
//                 (route) => false,
//               );
//             }
//           },
//           child: Builder(
//             builder: (blocContext) {
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 30),
//                       const Text(
//                         "Email",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       CustomTextFormField(
//                         controller: emailController,
//                         validator: Validator.validateEmail,
//                         hintText: "Enter your email",
//                         keyboardType: TextInputType.emailAddress,
//                         action: TextInputAction.next,
//                       ),
//                       const SizedBox(height: 30),
//                       const Text(
//                         "Password",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       CustomTextFormField(
//                         controller: passwordController,
//                         validator: Validator.validatePassword,
//                         hintText: "Enter your password",
//                         isPassword: true,
//                         keyboardType: TextInputType.visiblePassword,
//                         action: TextInputAction.done,
//                       ),
//                       const SizedBox(height: 30),
//                       MaterialButton(
//                         minWidth: double.infinity,
//                         height: 50,
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             blocContext.read<LoginCubit>().intent(
//                               LoginIntentLogin(
//                                 email: emailController.text.trim(),
//                                 password: passwordController.text,
//                               ),
//                             );
//                           }
//                         },
//                         color: const Color(0xff212121),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
//         floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
//             ? Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Text.rich(
//                   TextSpan(
//                     text: "Don't have an account? ",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xff6E6A7C),
//                     ),
//                     children: [
//                       TextSpan(
//                         text: "Sign Up",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Color(0xff212121),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.of(
//                               context,
//                             ).pushNamed(Routes.signUpScreen);
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/custom_text_field.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/core/utils/validator.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/di/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<LoginCubit>(),

      child: Scaffold(
        backgroundColor: const Color(0xffFAFAFA),

        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                setState(() {
                  isLoading = true;
                });
              }

              if (state is LoginError) {
                setState(() {
                  isLoading = false;
                });

                AppToast.showToast(
                  context: context,
                  title: "Login Failed",
                  description: state.message,
                  type: ToastificationType.error,
                );
              }

              if (state is LoginSuccess) {
                setState(() {
                  isLoading = false;
                });

                AppToast.showToast(
                  context: context,
                  title: "Welcome Back",
                  description: "Login Successfully",
                  type: ToastificationType.success,
                );

                Future.delayed(const Duration(milliseconds: 700), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.bottomNavigationScreen,
                    (route) => false,
                  );
                });
              }
            },

            builder: (context, state) {
              return Stack(
                children: [
                  // Background decoration
                  Positioned(
                    top: -80,
                    right: -60,

                    child: Container(
                      width: 220,
                      height: 220,

                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.04),

                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -100,
                    left: -50,

                    child: Container(
                      width: 250,
                      height: 250,

                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.03),

                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: Form(
                      key: formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const SizedBox(height: 45),

                          Center(
                                child: Container(
                                  width: 85,
                                  height: 85,

                                  decoration: BoxDecoration(
                                    color: Colors.black,

                                    borderRadius: BorderRadius.circular(25),
                                  ),

                                  child: const Icon(
                                    Icons.shopping_bag_outlined,

                                    color: Colors.white,

                                    size: 45,
                                  ),
                                ),
                              )
                              .animate()
                              .scale(
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                              )
                              .fade(),

                          const SizedBox(height: 30),

                          const Text(
                                "Welcome Back",

                                style: TextStyle(
                                  fontSize: 30,

                                  fontWeight: FontWeight.bold,

                                  color: Color(0xff1F1F1F),
                                ),
                              )
                              .animate()
                              .slideY(begin: -.3, duration: 500.ms)
                              .fade(),

                          const SizedBox(height: 8),

                          const Text(
                            "Login to continue shopping",

                            style: TextStyle(
                              fontSize: 15,

                              color: Color(0xff777777),
                            ),
                          ).animate().fade(delay: 200.ms),

                          const SizedBox(height: 45),

                          const Text(
                            "Email",

                            style: TextStyle(
                              fontSize: 15,

                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          CustomTextFormField(
                                controller: emailController,

                                validator: Validator.validateEmail,

                                hintText: "Enter your email",

                                keyboardType: TextInputType.emailAddress,

                                action: TextInputAction.next,
                              )
                              .animate()
                              .slideX(begin: -.2, duration: 500.ms)
                              .fade(),

                          const SizedBox(height: 25),

                          const Text(
                            "Password",

                            style: TextStyle(
                              fontSize: 15,

                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          CustomTextFormField(
                                controller: passwordController,

                                validator: Validator.validatePassword,

                                hintText: "Enter your password",

                                isPassword: true,

                                keyboardType: TextInputType.visiblePassword,

                                action: TextInputAction.done,
                              )
                              .animate()
                              .slideX(begin: .2, duration: 500.ms)
                              .fade(),

                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Forgot password
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xff555555),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<LoginCubit>().intent(
                                            LoginIntentLogin(
                                              email: emailController.text
                                                  .trim(),
                                              password: passwordController.text,
                                            ),
                                          );
                                        }
                                      },

                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),

                                  width: double.infinity,

                                  height: 56,

                                  decoration: BoxDecoration(
                                    color: const Color(0xff212121),

                                    borderRadius: BorderRadius.circular(16),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.15),

                                        blurRadius: 12,

                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),

                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),

                                      child: isLoading
                                          ? const SizedBox(
                                              width: 24,

                                              height: 24,

                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,

                                                color: Colors.white,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                Text(
                                                  "Login",

                                                  style: TextStyle(
                                                    color: Colors.white,

                                                    fontSize: 16,

                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                SizedBox(width: 8),

                                                Icon(
                                                  Icons.arrow_forward_rounded,

                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              )
                              .animate()
                              .slideY(begin: .4, duration: 500.ms)
                              .fade(),

                          const SizedBox(height: 35),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: Colors.grey.shade300),
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),

                                child: Text(
                                  "OR",

                                  style: TextStyle(
                                    color: Colors.grey,

                                    fontSize: 13,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Divider(color: Colors.grey.shade300),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",

                                style: const TextStyle(
                                  color: Color(0xff777777),

                                  fontSize: 14,
                                ),

                                children: [
                                  TextSpan(
                                    text: "Sign Up",

                                    style: const TextStyle(
                                      color: Color(0xff212121),

                                      fontSize: 14,

                                      fontWeight: FontWeight.bold,
                                    ),

                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                          context,

                                          Routes.signUpScreen,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ).animate().fade(delay: 300.ms),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
