import 'package:flutter/material.dart';
import 'package:todo_app/screens/all_task/view/all_task_screen.dart';
import 'package:todo_app/screens/profile/profile_screen.dart';
import 'package:todo_app/screens/profile/sub_screens/change_theme_screen.dart';

class AppRoutes {
  static const String allTaskScreen = "/";
  static const String profileScreen = "profileScreen";
  static const String changeThemeScreen = "changeThemeScreen";

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {

      case allTaskScreen:
        return MaterialPageRoute(builder: (context) => const AllTaskScreen());

      case profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());

      case changeThemeScreen:
              return MaterialPageRoute(builder: (context) => const ChangeThemeScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Center(child: Text("No routes found"))),
        );
    }
  }
}
