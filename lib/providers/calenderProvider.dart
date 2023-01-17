import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gtd/models/categoryModel.dart';
import 'package:hive/hive.dart';

import '../models/toDoModel.dart';

class CalenderProvider with ChangeNotifier {
  String calenderBox = 'calenderBox';
  String calenderToDoTextBox = 'calenderToDoTextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(calenderBox);
    box.add(product);
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(calenderBox);
    _categoryList = box.values.toList();
    // calculateTotalPrice();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(calenderBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(calenderBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }

  // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(calenderToDoTextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(calenderToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(calenderToDoTextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(calenderToDoTextBox);
    box.deleteAt(index);
    getCategory();
    log('Delete item');

    notifyListeners();
  }
}
