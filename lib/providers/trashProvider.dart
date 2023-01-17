import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/categoryModel.dart';
import '../models/toDoModel.dart';

class TrashProvider with ChangeNotifier {
  String trashBox = 'trashBox';
  String trashtodoBox = 'trashtodoBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(trashBox);
    box.add(product);
    log("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(trashBox);
    _categoryList = box.values.toList();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(trashBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(trashBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }


   // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(trashtodoBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(trashtodoBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(trashtodoBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(trashtodoBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
