import 'package:flutter/material.dart';
import 'package:surveyor_app/features/addUpdateUser/add_update_user_screen.dart';
import 'package:surveyor_app/features/home/home_screen.dart';
import 'package:surveyor_app/features/login/login_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (_) => const LoginScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    AddUpdateUserScreen.routeName: (_) => const AddUpdateUserScreen(),
  };
}
