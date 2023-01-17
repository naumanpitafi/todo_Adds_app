import 'package:hive/hive.dart';

part 'inboxModel.g.dart';

@HiveType(typeId: 3)
class InboxModel {
  @HiveField(0)
  String? todoText;
  @HiveField(1)
  String? dateTime;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? extendedate;
  @HiveField(4)
  String? trashStatus;
  @HiveField(5)
  String? somedayMaybeStatus;
  @HiveField(6)
  String? referenceStatus;



  InboxModel({
    required this.todoText,
    required this.dateTime,
    required this.status,
    required this.extendedate,
    required this.trashStatus,
    required this.somedayMaybeStatus,
    required this.referenceStatus,
  });
}
