import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/custom_text_field.dart';
import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/utils/app_toast.dart';
import 'package:shopping_app/core/utils/validator.dart';
import 'package:shopping_app/core/widgets/password_strength_widget.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/register_cubit.dart';
import 'package:shopping_app/feature/auth/presentation/view_model/register_state.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),

      body: SafeArea(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              setState(() {
                isLoading = true;
              });
            }

            if (state is RegisterError) {
              setState(() {
                isLoading = false;
              });

              AppToast.showToast(
                context: context,

                title: "Sign Up Failed",

                description: state.message ?? "Something went wrong",

                type: ToastificationType.error,
              );
            }

            if (state is RegisterSuccess) {
              setState(() {
                isLoading = false;
              });

              AppToast.showToast(
                context: context,

                title: "Success",

                description: "Account created successfully",

                type: ToastificationType.success,
              );

              Future.delayed(const Duration(milliseconds: 700), () {
                Navigator.pushNamed(context, Routes.logInScreen);
              });
            }
          },

          builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: -90,

                  left: -60,

                  child: Container(
                    width: 230,

                    height: 230,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: Colors.black.withOpacity(.04),
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
                        const SizedBox(height: 40),

                        Center(
                              child: Container(
                                width: 85,

                                height: 85,

                                decoration: BoxDecoration(
                                  color: Colors.black,

                                  borderRadius: BorderRadius.circular(25),
                                ),

                                child: const Icon(
                                  Icons.person_add_alt_1_rounded,

                                  color: Colors.white,

                                  size: 45,
                                ),
                              ),
                            )
                            .animate()
                            .scale(duration: 600.ms, curve: Curves.easeOutBack)
                            .fade(),

                        const SizedBox(height: 25),

                        const Text(
                          "Create Account",

                          style: TextStyle(
                            fontSize: 30,

                            fontWeight: FontWeight.bold,

                            color: Color(0xff1F1F1F),
                          ),
                        ).animate().slideY(begin: -.3, duration: 500.ms).fade(),

                        const SizedBox(height: 8),

                        const Text(
                          "Let's get you started",

                          style: TextStyle(
                            fontSize: 15,

                            color: Color(0xff777777),
                          ),
                        ).animate().fade(delay: 200.ms),

                        const SizedBox(height: 35),

                        const Text(
                          "Full Name",

                          style: TextStyle(
                            fontSize: 15,

                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        CustomTextFormField(
                          controller: nameController,

                          validator: Validator.validateName,

                          hintText: "Enter your name",

                          keyboardType: TextInputType.name,

                          action: TextInputAction.next,
                        ).animate().slideX(begin: -.2, duration: 400.ms).fade(),

                        const SizedBox(height: 20),
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
                        ).animate().slideX(begin: .2, duration: 400.ms).fade(),

                        const SizedBox(height: 20),

                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        CustomTextFormField(
                          controller: phoneController,
                          validator: (value) =>
                              Validator.validateConfirmPassword(
                                value,
                                phoneController.text,
                              ),
                          hintText: "Confirm your Phone",
                          isPassword: true,
                        ).animate().slideX(begin: -.2, duration: 400.ms).fade(),

                        const SizedBox(height: 20),

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
                          action: TextInputAction.next,
                        ).animate().slideX(begin: .2, duration: 400.ms).fade(),

                        const SizedBox(height: 10),

                        PasswordStrengthWidget(
                          passwordController: passwordController,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        CustomTextFormField(
                          controller: confirmPasswordController,
                          validator: (value) =>
                              Validator.validateConfirmPassword(
                                value,
                                passwordController.text,
                              ),
                          hintText: "Confirm your password",
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          action: TextInputAction.done,
                        ).animate().slideX(begin: -.2, duration: 400.ms).fade(),

                        const SizedBox(height: 35),

                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    final request = RegisterRequestEntity(
                                      name: nameController.text.trim(),

                                      phone: phoneController.text.trim(),

                                      email: emailController.text.trim(),

                                      password: passwordController.text.trim(),

                                      confirmPassword: confirmPasswordController
                                          .text
                                          .trim(),
                                    );

                                    context.read<RegisterCubit>().intent(
                                      RegisterIntentRegister(request: request),
                                    );
                                  }
                                },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            height: 56,

                            width: double.infinity,

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
                                duration: const Duration(milliseconds: 250),

                                child: isLoading
                                    ? const SizedBox(
                                        width: 24,

                                        height: 24,

                                        child: CircularProgressIndicator(
                                          color: Colors.white,

                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Text(
                                            "Create Account",

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
                        ).animate().slideY(begin: .4, duration: 500.ms).fade(),

                        const SizedBox(height: 30),

                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",

                              style: const TextStyle(
                                color: Color(0xff777777),

                                fontSize: 14,
                              ),

                              children: [
                                TextSpan(
                                  text: "Login",

                                  style: const TextStyle(
                                    color: Color(0xff212121),

                                    fontWeight: FontWeight.bold,
                                  ),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                        context,

                                        Routes.logInScreen,
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
    );
  }
}
