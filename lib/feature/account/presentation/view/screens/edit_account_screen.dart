import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/widget/text_field.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_state.dart';

import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/image_helper.dart';
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
      create: (_) => serviceLocator<AccountCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
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
              final imageUrl = ImageHelper.getImageUrl(widget.account.image);
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.charcoal,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),

                      const SizedBox(height: 24),

                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey.shade200,
                              child: ClipOval(
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        imageUrl,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) {
                                          return const Icon(
                                            Icons.person,
                                            size: 70,
                                            color: Colors.orange,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
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
                                    AppAssets.camera,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

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

                      const SizedBox(height: 16),

                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

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

                      const SizedBox(height: 16),

                      Text(
                        "Phone",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: "Enter your phone",
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Address",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),

                      CustomTextFormField(
                        controller: _addressController,
                        hintText: "Enter your address",
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          txt: "Submit",
                          width: 343,
                          height: 48,
                          color: const Color(0xff121212),
                          borderColor: const Color(0xff121212),
                          txtColor: Colors.white,
                          fun: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AccountCubit>().intent(
                                UpdateAccountIntent(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  email: _emailController.text.trim(),
                                  address: _addressController.text.trim(),
                                  currentImage: widget.account.image,
                                  image: selectedImage,
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
