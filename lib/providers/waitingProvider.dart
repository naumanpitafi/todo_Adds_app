import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/categoryModel.dart';
import '../models/toDoModel.dart';

class WaitingProvider with ChangeNotifier {
  String waitingBox = 'waitingBox';
  String waitingToDoTextBox = 'waitingToDoTextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(waitingBox);
    box.add(product);
    print("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(waitingBox);
    _categoryList = box.values.toList();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(waitingBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(waitingBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }

  // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(waitingToDoTextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(waitingToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(waitingToDoTextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(waitingToDoTextBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
