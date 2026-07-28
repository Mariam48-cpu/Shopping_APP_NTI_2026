import 'package:flutter/material.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/edit_account_screen.dart';
import 'package:shopping_app/feature/account/presentation/view/screens/widget/account_info_title.dart';

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
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
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
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Color(0xffff9900),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mohamed Essam",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 38),
              Container(
                decoration: BoxDecoration(
                  color:  Color(0xffffffff),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    AccountInfoTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Full Name',
                      value: 'Mohamed Essam',
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
                      value: 'Mohamed@gmail.com',
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
                      value: '+20 123 456 7890',
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
                      value: 'Cairo, Egypt',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccountScreen(),
                    ),
                  );
                },
                borderColor: Color(0xff121212),
                txtColor: Color(0xffffffff),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

