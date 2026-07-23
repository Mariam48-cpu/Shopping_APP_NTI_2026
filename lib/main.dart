import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/app_routers.dart';
import 'package:shopping_app/core/routes/routes.dart';
import 'package:shopping_app/feature/auth/presentation/screens/hello.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelloScreen(),
      // initialRoute: RouteLayers.registerRoute,
      onGenerateRoute: AppRouters.createRoute,
    );
  }
}
