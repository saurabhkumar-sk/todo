import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  bool isCompleted;

  // 🔥 NEW FIELDS
  @HiveField(3)
  String? firestoreId;

  @HiveField(4)
  bool isSynced;

  TodoModel({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.firestoreId,
    this.isSynced = false,
  });
}