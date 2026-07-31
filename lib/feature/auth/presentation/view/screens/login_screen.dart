import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/custom_text_field.dart';
import 'package:shopping_app/core/utils/app_dialogs.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/validator.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => serviceLocator<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff1F1F1F),
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (BuildContext context, state) {
            if (state is LoginLoading) {
              AppDialogs.showLoadingDialog(context);
            } else if (state is LoginError) {
              Navigator.of(context, rootNavigator: true).pop();
              AppToast.showToast(
                context: context,
                title: "Error",
                description: state.message,
                type: ToastificationType.error,
              );
            } else if (state is LoginSuccess) {
              // إغلاق الـ Loading Dialog أولاً
              Navigator.of(context, rootNavigator: true).pop();

              // 👈 التعديل هنا: التوجيه لـ bottomNavigationScreen بدلاً من homeScreen
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bottomNavigationScreen,
                (route) => false,
              );
            }
          },
          child: Builder(
            builder: (blocContext) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        controller: emailController,
                        validator: Validator.validateEmail,
                        hintText: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        action: TextInputAction.next,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        controller: passwordController,
                        validator: Validator.validatePassword,
                        hintText: "Enter your password",
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        action: TextInputAction.done,
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            blocContext.read<LoginCubit>().intent(
                              LoginIntentLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        color: const Color(0xff212121),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff6E6A7C),
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(
                              context,
                            ).pushNamed(Routes.signUpScreen);
                          },
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
