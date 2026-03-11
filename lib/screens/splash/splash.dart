import 'package:flutter/material.dart';
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
      Future.delayed(Duration(seconds: 4),() {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.allTaskScreen);
      },);
    },);
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