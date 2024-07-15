import 'package:db_miner/view/favorite_page.dart';
import 'package:db_miner/view/home_page.dart';
import 'package:db_miner/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/home_page", page: () => HomePage(), transition: Transition.zoom,
        ),
        GetPage(name: "/favorite_page", page: () => FavoritePage(),
        ),
      ],
    );
  }
}
