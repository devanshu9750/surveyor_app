import 'package:flutter/material.dart';
import 'package:surveyor_app/core/app_router.dart';
import 'package:surveyor_app/features/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: LoginScreen.routeName, routes: AppRouter.routes);
  }
}
