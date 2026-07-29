import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/widget/text_field.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_state.dart';

import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/account_entity.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key, required this.account});

  final AccountEntity account;
  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account.name);

    _emailController = TextEditingController(text: widget.account.email);

    _phoneController = TextEditingController(text: widget.account.phone);

    _addressController = TextEditingController(text: widget.account.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AccountCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<AccountCubit, AccountState>(
              listener: (context, state) {
                if (state is AccountUpdateSuccess) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));

                  Navigator.pop(context, true);
                }
                if (state is AccountUpdateError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.messageError)));
                }
              },
              builder: (context, state) {
                return Form(
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
                              backgroundImage: selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : NetworkImage(widget.account.image)
                                        as ImageProvider,
                            ),

                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.charcoal,
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

                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                      Text(
                        "Phone",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: "Enter your phone",
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Address",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

                      CustomTextFormField(
                        controller: _addressController,
                        hintText: "Enter your address",
                      ),
                      SizedBox(height: 114),
                      Center(
                        child: CustomButton(
                          txt: "Submit",
                          width: 343,
                          height: 48,
                          color: Color(0xff121212),
                          fun: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AccountCubit>().intent(
                                UpdateAccountIntent(
                                  name: _nameController.text,

                                  phone: _phoneController.text,

                                  email: _emailController.text,

                                  address: _addressController.text,

                                  image: selectedImage,
                                ),
                              );
                            }
                          },
                          borderColor: Color(0xff121212),
                          txtColor: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
