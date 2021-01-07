import 'package:flutter/material.dart';
import 'package:flutter_app/src/app.dart';
import 'package:flutter_app/src/services/auth_service.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ShoesService());
  GetIt.I.registerLazySingleton(() => AuthService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}
