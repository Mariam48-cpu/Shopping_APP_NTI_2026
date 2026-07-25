import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/app_routers.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.helloScreen ,
      onGenerateRoute: AppRouters.createRoute,
    );
  }
}
