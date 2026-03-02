import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.allTaskScreen,
      onGenerateRoute: AppRoutes.generateRoutes,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: AppColors.primary),
        colorScheme:.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

