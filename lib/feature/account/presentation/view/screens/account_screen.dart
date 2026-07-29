import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/edit_account_screen.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/widget/account_info_title.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_state.dart';

import '../../../../../core/common/widgets/custom_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) =>
              serviceLocator<AccountCubit>()..intent(FetchAccountIntent()),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: BlocBuilder<AccountCubit, AccountState>(
              builder: (context, state) {
                if (state is AccountLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AccountError) {
                  return Center(child: Text(state.messageError));
                }
                if (state is AccountSuccess) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          Icon(Icons.notifications_none),
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundImage: state.account.image.isNotEmpty
                                    ? NetworkImage(state.account.image)
                                    : null,

                                child: state.account.image.isEmpty
                                    ? Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Color(0xffff9900),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        state.account.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        state.account.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      SizedBox(height: 38),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            AccountInfoTile(
                              icon: Icons.person_outline_rounded,
                              title: 'Full Name',
                              value: state.account.name,
                            ),
                            Divider(
                              height: 4,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xFFEEEEEE),
                            ),

                            AccountInfoTile(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: state.account.email,
                            ),
                            Divider(
                              height: 4,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xFFEEEEEE),
                            ),

                            AccountInfoTile(
                              icon: Icons.lock_outline_rounded,
                              title: 'Password',
                              value: '********',
                            ),
                            Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xFFEEEEEE),
                            ),

                            AccountInfoTile(
                              icon: Icons.phone_outlined,
                              title: 'Phone',
                              value: state.account.phone,
                            ),
                            Divider(
                              height: 4,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xFFEEEEEE),
                            ),

                            AccountInfoTile(
                              icon: Icons.location_on_outlined,
                              title: 'Address',
                              value: state.account.address,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 80),

                      CustomButton(
                        txt: "Edit Profile",
                        width: 343,
                        height: 48,
                        color: Color(0xff121212),
                        fun: () {
                          final result = Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditAccountScreen(account: state.account),
                            ),
                          );
                          if (result == true) {
                            context.read<AccountCubit>().intent(
                              FetchAccountIntent(),
                            );
                          }
                        },
                        borderColor: Color(0xff121212),
                        txtColor: Color(0xffffffff),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
