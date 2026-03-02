import 'package:flutter/material.dart';
import 'package:todo_app/screens/all_task/view/all_task_screen.dart';

class AppRoutes {
  static const String allTaskScreen = "/";

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case allTaskScreen:
        return MaterialPageRoute(builder: (context) => const AllTaskScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Center(child: Text("No routes found"))),
        );
    }
  }
}
