import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/all_task/model/todo_model.dart';

class AllTaskProvider extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();

  final Box<TodoModel> _box = Hive.box<TodoModel>(storageKey);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  void setIsCompleted(bool complete){
    _isCompleted = complete;
    notifyListeners();
  }

  List<TodoModel> get todos => _box.values.toList().cast<TodoModel>();

  void addTodos({required String title, String? description, required bool isCompleted}) {
    _box.add(TodoModel(title: title, description: description, isCompleted: isCompleted));
    Navigator.pop(navigatorKey.currentContext!);
    titleController.clear();
    descriptionController.clear();
    _isCompleted = false;
    notifyListeners();
  }

  void deleteTodos(int index){
    _box.deleteAt(index);
    notifyListeners();
  }


  void toggleCompleted(int index) {
    final todo = _box.getAt(index);

    _box.putAt(index, TodoModel(
      title: todo?.title,
      description: todo?.description,
      isCompleted: !(todo?.isCompleted ?? false),
    ));

    notifyListeners();
  }

  void updateTodos({required int index,required String title,String? description,required bool isCompleted}){
    _box.putAt(index, TodoModel(
      title: title,
      description: description,
      isCompleted: isCompleted,
    ));
    Navigator.pop(navigatorKey.currentContext!);
    titleController.clear();
    descriptionController.clear();
    _isCompleted = false;
    notifyListeners();
  }

}
// class AllTaskProvider extends ChangeNotifier{
//
//   final formKey = GlobalKey<FormState>();
//
//   final Box _box = Hive.box(storageKey);
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   bool _isCompleted = false;
//   bool get isCompleted => _isCompleted;
//   void setIsCompleted(bool complete){
//     _isCompleted = complete;
//     notifyListeners();
//   }
//
//   List get todos => _box.values.toList();
//
//   void addTodos({required String title,String? description, required bool isCompleted}){
//     _box.add({
//       "title": title,
//       "description": description,
//       "isCompleted": isCompleted
//     }).then((value) {
//       titleController.clear();
//       descriptionController.clear();
//       _isCompleted = false;
//       Navigator.pop(navigatorKey.currentContext!);
//     },);
//     notifyListeners();
//   }
//
//   void deleteTodos(int index){
//     _box.deleteAt(index);
//     notifyListeners();
//   }
//
//
//   void toggleCompleted(int index) {
//     final todo = _box.getAt(index);
//
//     _box.putAt(index, {
//       "title": todo['title'],
//       "description": todo['description'],
//       "isCompleted": !(todo['isCompleted'] ?? false),
//     });
//
//     notifyListeners();
//   }
//
//   void updateTodos({required int index,required String title,String? description,required bool isCompleted}){
//     _box.putAt(index, {
//       "title": title,
//       "description": description,
//       "isCompleted": isCompleted,
//     });
//     Navigator.pop(navigatorKey.currentContext!);
//     titleController.clear();
//     descriptionController.clear();
//     _isCompleted = false;
//     notifyListeners();
//   }
//
// }