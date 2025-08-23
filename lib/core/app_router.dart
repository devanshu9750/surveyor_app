import 'package:flutter/material.dart';
import 'package:surveyor_app/features/addUpdateAnimal/add_update_animal_screen.dart';
import 'package:surveyor_app/features/addUpdateUser/add_update_user_screen.dart';
import 'package:surveyor_app/features/animalDetail/animal_detail_screen.dart';
import 'package:surveyor_app/features/viewDocuments/view_documents_screen.dart';
import 'package:surveyor_app/features/home/home_screen.dart';
import 'package:surveyor_app/features/login/login_screen.dart';
import 'package:surveyor_app/models/animal.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (_) => const LoginScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    AddUpdateUserScreen.routeName: (_) => const AddUpdateUserScreen(),
    AddUpdateAnimalScreen.routeName: (_) => const AddUpdateAnimalScreen(),
    AnimalDetailScreen.routeName: (_) => const AnimalDetailScreen(),
    ViewDocumentsScreen.routeName: (context) {
      final documents = ModalRoute.of(context)!.settings.arguments as List<InspectionImage>;
      return ViewDocumentsScreen(inspectionImages: documents);
    },
  };
}
