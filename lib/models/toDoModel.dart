import 'package:hive/hive.dart';

part 'toDoModel.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  String? catgName;
  @HiveField(1)
  String? text;
  @HiveField(3)
  String? dateTime;
  @HiveField(4)
  String? status;

  TodoModel({
    required this.catgName,
    required this.text,
    required this.dateTime,
    required this.status,
  });
}
