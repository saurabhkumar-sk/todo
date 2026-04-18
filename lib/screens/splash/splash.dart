import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/routes/routes.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin();
    },);
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 4));

    final box = Hive.box(loginBoxKey);
     final isLoggedIn = box.get('isLoggedIn',defaultValue: "skip");
     debugPrint("isLoggedIn $isLoggedIn");

    if (isLoggedIn == "google" || isLoggedIn == "skip") {
      Navigator.pushReplacementNamed(
        navigatorKey.currentContext!,
        AppRoutes.allTaskScreen,
      );
    } else {
      Navigator.pushReplacementNamed(
        navigatorKey.currentContext!,
        AppRoutes.loginScreen,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Theme.of(navigatorKey.currentContext!).primaryColor,
          child : Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Center(child: Lottie.asset("assets/images/Task.json")),
          ),
      ),
    );
  }
}