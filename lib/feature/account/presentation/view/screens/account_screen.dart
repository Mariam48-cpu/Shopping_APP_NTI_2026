import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/edit_account_screen.dart';
import 'package:shopping_app/feature/account/presentation/view/widget/account_info_title.dart';
import 'package:shopping_app/feature/account/presentation/view/widget/account_skeleton.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_state.dart';

import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/utils/image_helper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<AccountCubit>()..intent(FetchAccountIntent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AccountCubit, AccountState>(
              builder: (context, state) {
                if (state is AccountLoading) {
                  return const AccountSkeleton();
                }

                if (state is AccountError) {
                  return Center(child: Text(state.messageError));
                }

                if (state is AccountSuccess) {
                  final imageUrl = ImageHelper.getImageUrl(state.account.image);

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Account",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const Icon(Icons.notifications_none),
                          ],
                        ),

                        const SizedBox(height: 16),

                        CircleAvatar(
                          radius: 64,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : null,
                          child: imageUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Color(0xffff9900),
                                )
                              : null,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          state.account.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          state.account.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 32),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              AccountInfoTile(
                                icon: Icons.person_outline_rounded,
                                title: "Full Name",
                                value: state.account.name,
                              ),
                              const Divider(indent: 16, endIndent: 16),

                              AccountInfoTile(
                                icon: Icons.email_outlined,
                                title: "Email",
                                value: state.account.email,
                              ),
                              const Divider(indent: 16, endIndent: 16),

                              const AccountInfoTile(
                                icon: Icons.lock_outline_rounded,
                                title: "Password",
                                value: "********",
                              ),
                              const Divider(indent: 16, endIndent: 16),

                              AccountInfoTile(
                                icon: Icons.phone_outlined,
                                title: "Phone",
                                value: state.account.phone,
                              ),
                              const Divider(indent: 16, endIndent: 16),

                              AccountInfoTile(
                                icon: Icons.location_on_outlined,
                                title: "Address",
                                value: state.account.address,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        CustomButton(
                          txt: "Edit Profile",
                          width: 343,
                          height: 48,
                          color: const Color(0xff121212),
                          borderColor: const Color(0xff121212),
                          txtColor: Colors.white,
                          fun: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditAccountScreen(account: state.account),
                              ),
                            );

                            if (result == true && context.mounted) {
                              context.read<AccountCubit>().intent(
                                FetchAccountIntent(),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
