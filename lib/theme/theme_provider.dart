import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';

class ThemeProvider extends ChangeNotifier{

  final Box _box = Hive.box(storageKey);

  static const String _themeKey = "themeMode";

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider(){
    _loadTheme();
  }

  void _loadTheme(){
    final save = _box.get(_themeKey);
    if(save != null){
      _themeMode = ThemeMode.values[save];
    }
    debugPrint("theme mode >>> $_themeMode >>  $save");

    notifyListeners();
  }

  void setTheme(ThemeMode mode){
    _themeMode = mode;
    _box.put(_themeKey, mode.index);
    notifyListeners();
  }

  int get selectedThemeIndex {
    switch (themeMode) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.dark:
        return 1;
      case ThemeMode.system:
        return 2;
    }
  }

}