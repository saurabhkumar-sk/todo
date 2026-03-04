import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/theme/app_theme.dart';
import 'package:todo_app/theme/theme_provider.dart';

import 'screens/all_task/controller/all_task_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const String storageKey = "myTodos";
const String themeBoxKey = "themeMode";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox(storageKey);
  await Hive.openBox(themeBoxKey);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (context) => ThemeProvider()),
        ChangeNotifierProvider(create:  (context) => AllTaskProvider())
      ],
      child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer<ThemeProvider>(
        builder: (context,themeProvider,_) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.allTaskScreen,
            onGenerateRoute: AppRoutes.generateRoutes,
            title: 'My Todo App',
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        }
      ),
    );
  }
}

