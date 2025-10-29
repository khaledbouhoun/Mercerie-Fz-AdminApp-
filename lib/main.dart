import 'package:admin_ecommerce_app/core/intialbindings.dart';
import 'package:admin_ecommerce_app/core/services/services.dart';
import 'package:admin_ecommerce_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, initialBinding: InitialBindings(), getPages: routes);
  }
}
