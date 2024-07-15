import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff060A13),
        body: TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            onEnd: () {
              Get.offAndToNamed("home_page");
            },
            tween: Tween(begin: 0.0, end: 160.0),
            builder: (context, value, child) {
              return Center(
                child: Image.network(
                  "https://cdna.artstation.com/p/assets/images/images/011/894/994/large/jerry-ubah-logo3.jpg?1531974609",
                  height: 200,
                ),
              );
            }));
  }
}
