import 'package:hive/hive.dart';

part 'deleteModel.g.dart';

@HiveType(typeId: 2)
class DeleteModel {
  @HiveField(0)
  String? catgName;
  @HiveField(1)
  String? todotext;
  @HiveField(2)
  String? dateTime;
  @HiveField(3)
  String? todoName;

  DeleteModel({
    required this.catgName,
    required this.todotext,
    required this.dateTime,
    required this.todoName,
  });
}
