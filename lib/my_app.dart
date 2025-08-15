import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:surveyor_app/core/app_router.dart';
import 'package:surveyor_app/features/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      initialRoute: LoginScreen.routeName,
      routes: AppRouter.routes,
    );
  }
}
