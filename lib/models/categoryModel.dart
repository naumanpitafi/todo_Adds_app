import 'package:hive/hive.dart';

part 'categoryModel.g.dart';

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? color;

  CategoryModel({
    required this.name,
    required this.color,
  });
}
