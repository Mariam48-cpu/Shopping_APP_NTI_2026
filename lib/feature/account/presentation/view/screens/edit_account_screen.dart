import 'package:flutter/material.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/widget/text_field.dart';

import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/theme/app_colors.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: _formKey,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.charcoal,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 48),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: const AssetImage(
                          "assets/image/profile.png",
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.charcoal.withOpacity(0.08),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/image/camira.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 38),

                Text("Name", style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: "Enter your name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Text("Email", style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                ),
                Text("Password", style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8),
                CustomTextFormField(
                  controller: _passwordController,
                  isPassword: true,
                  hintText: "Enter your password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 114),
                Center(
                  child: CustomButton(
                    txt: "Submit",
                    width: 343,
                    height: 48,
                    color: Color(0xff121212),
                    fun: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditAccountScreen(),
                      //   ),
                      //);
                    },
                    borderColor: Color(0xff121212),
                    txtColor: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
