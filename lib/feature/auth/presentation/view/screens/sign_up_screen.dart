import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/utils/app_dialogs.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_toast.dart';
import '../../../../../core/utils/validator.dart';
import '../../view_model/register_cubit.dart';
import '../../view_model/register_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {
                AppDialogs.showLoadingDialog(context);
              }

              if (state is RegisterError) {
                Navigator.of(context, rootNavigator: true).pop();
                AppToast.showToast(
                  context: context,
                  title: "Error",
                  description: state.message!,
                  type: ToastificationType.error,
                );
              }
              if (state is RegisterSuccess) {
                Navigator.pushNamed(context, Routes.logInScreen);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: nameController,
                  validator: (value) => Validator.validateName(value),
                  hintText: "Enter your name",

                  keyboardType: TextInputType.name,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),

                Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: phoneNumberController,
                  validator: (value) => Validator.validatePhoneNumber(value),
                  hintText: "Enter your phone number",

                  keyboardType: TextInputType.phone,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: "Enter your password",
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) => Validator.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                  hintText: "Confirm your password",
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var request = RegisterRequestEntity(
                        name: nameController.text,
                        phone: phoneNumberController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                      context.read<RegisterCubit>().intent(
                        RegisterIntentRegister(request: request),
                      );
                    }
                  },
                  color: Color(0xff212121),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "SignUp",
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(fontSize: 14, color: Color(0xff6E6A7C)),

                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(Routes.logInScreen);
                        },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
