import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // void addTodos({required String title, String? description, required bool isCompleted}) {
  //   _box.add(TodoModel(title: title, description: description, isCompleted: isCompleted));
  //   Navigator.pop(navigatorKey.currentContext!);
  //   titleController.clear();
  //   descriptionController.clear();
  //   _isCompleted = false;
  //   notifyListeners();
  // }
  Future<void> addTodo(BuildContext context) async {

    final loginType = Hive.box(loginBoxKey)
        .get("isLoggedIn", defaultValue: "skip");

    final newTodo = TodoModel(
      title: titleController.text,
      description: descriptionController.text,
      isCompleted: _isCompleted,
      isSynced: loginType == "google",
    );

    // 👉 Local save
    int index = await _box.add(newTodo);

    // 👉 Firestore save (only google user)
    if (loginType == "google") {
      await _addToFirestore(index);
    }

    _clearAndClose();
  }

  Future<void> _addToFirestore(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final todo = _box.getAt(index);

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("todos")
        .add({
      "title": todo?.title,
      "description": todo?.description,
      "isCompleted": todo?.isCompleted,
      "createdAt": FieldValue.serverTimestamp(),
    });

    // 👉 update local with firestoreId
    await _box.putAt(index, TodoModel(
      title: todo?.title,
      description: todo?.description,
      isCompleted: todo?.isCompleted ?? false,
      firestoreId: doc.id,
      isSynced: true,
    ));
  }


  Stream<List<TodoModel>> getFirestoreTodos() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("todos")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return TodoModel(
          title: data["title"],
          description: data["description"],
          isCompleted: data["isCompleted"] ?? false,
          firestoreId: doc.id,
          isSynced: true,
        );
      }).toList();
    });
  }

  void _clearAndClose() {
    Navigator.pop(navigatorKey.currentContext!);
    titleController.clear();
    descriptionController.clear();
    _isCompleted = false;
    notifyListeners();
  }

  // void deleteTodos(int index){
  //   _box.deleteAt(index);
  //   notifyListeners();
  // }
  Future<void> deleteTodos(int index) async {

    final loginType = Hive.box(loginBoxKey).get("isLoggedIn");

    final todo = _box.getAt(index);

    // 👉 Firebase delete
    if (loginType == "google" && todo?.firestoreId != null) {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("todos")
          .doc(todo!.firestoreId)
          .delete();
    }

    // 👉 Local delete
    await _box.deleteAt(index);

    notifyListeners();
  }

  // void toggleCompleted(int index) {
  //   final todo = _box.getAt(index);
  //
  //   _box.putAt(index, TodoModel(
  //     title: todo?.title,
  //     description: todo?.description,
  //     isCompleted: !(todo?.isCompleted ?? false),
  //   ));
  //
  //   notifyListeners();
  // }
  Future<void> toggleCompleted(int index) async {

    final loginType = Hive.box(loginBoxKey).get("isLoggedIn");

    final todo = _box.getAt(index);

    final updated = !(todo?.isCompleted ?? false);

    // 👉 Local update
    await _box.putAt(index, TodoModel(
      title: todo?.title,
      description: todo?.description,
      isCompleted: updated,
      firestoreId: todo?.firestoreId,
      isSynced: todo?.isSynced ?? false,
    ));

    // 👉 Firebase update
    if (loginType == "google" && todo?.firestoreId != null) {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("todos")
          .doc(todo!.firestoreId)
          .update({
        "isCompleted": updated,
      });
    }

    notifyListeners();
  }
  // void updateTodos({required int index,required String title,String? description,required bool isCompleted}){
  //   _box.putAt(index, TodoModel(
  //     title: title,
  //     description: description,
  //     isCompleted: isCompleted,
  //   ));
  //   Navigator.pop(navigatorKey.currentContext!);
  //   titleController.clear();
  //   descriptionController.clear();
  //   _isCompleted = false;
  //   notifyListeners();
  // }
  Future<void> updateTodos({
    required int index,
    required String title,
    String? description,
    required bool isCompleted,
  }) async {

    final loginType = Hive.box(loginBoxKey).get("isLoggedIn");

    final oldTodo = _box.getAt(index);

    final updatedTodo = TodoModel(
      title: title,
      description: description,
      isCompleted: isCompleted,
      firestoreId: oldTodo?.firestoreId,
      isSynced: oldTodo?.isSynced ?? false,
    );

    // 👉 Local update
    await _box.putAt(index, updatedTodo);

    // 👉 Firebase update
    if (loginType == "google" && oldTodo?.firestoreId != null) {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("todos")
          .doc(oldTodo!.firestoreId)
          .update({
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
      });
    }

    _clearAndClose();
  }
}
