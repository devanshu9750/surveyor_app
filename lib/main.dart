import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surveyor_app/my_app.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await GetStorage.init();
  runApp(const MyApp());
}
