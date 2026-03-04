import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';

class AllTaskProvider extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();

  final Box _box = Hive.box(storageKey);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  void setIsCompleted(bool complete){
    _isCompleted = complete;
    notifyListeners();
  }

  List get todos => _box.values.toList();

  void addTodos({required String title,String? description, required bool isCompleted}){
    _box.add({
      "title": title,
      "description": description,
      "isCompleted": isCompleted
    }).then((value) {
      titleController.clear();
      descriptionController.clear();
      _isCompleted = false;
      Navigator.pop(navigatorKey.currentContext!);
    },);
    notifyListeners();
  }

  void deleteTodos(int index){
    _box.deleteAt(index);
    notifyListeners();
  }

}