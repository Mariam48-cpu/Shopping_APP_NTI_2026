import 'package:flutter/material.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_routers.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.firstOnBoardingScreen,
      onGenerateRoute: AppRouters.createRoute,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shopping_app/core/constants/app_keys.dart';
// import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
// import 'core/di/service_locator.dart';
// import 'core/routes/app_routers.dart';
// import 'core/routes/app_routes.dart';
// import 'core/theme/app_theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   configureDependencies();

//   String? token = await SecureStorageHelper.instance.getSecure(
//     key: AppKeys.token,
//   );
//   String? isFirstTimeStr = await SecureStorageHelper.instance.getSecure(
//     key: 'is_first_time',
//   );

//   bool isFirstTime = isFirstTimeStr == null;
//   runApp(MyApp(token: token, isFirstTime: isFirstTime));
// }

// class MyApp extends StatelessWidget {
//   final String? token;
//   final bool isFirstTime;
//   const MyApp({super.key, required this.token, required this.isFirstTime});

//   String getInitialRoute() {
//     if (token != null && token!.isNotEmpty) {
//       return Routes.homeScreen;
//     } else if (isFirstTime) {
//       return Routes.firstOnBoardingScreen;
//     } else {
//       return Routes.logInScreen;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: getInitialRoute(),
//       onGenerateRoute: AppRouters.createRoute,
//       debugShowCheckedModeBanner: false,
//       title: 'Shopping App',
//       theme: AppTheme.lightTheme,
//     );
//   }
// }
