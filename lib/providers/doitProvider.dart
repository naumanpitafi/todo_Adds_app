import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gtd/models/categoryModel.dart';
import 'package:gtd/models/toDoModel.dart';
import 'package:hive/hive.dart';

class DoitProvider with ChangeNotifier {
  // Category Work
  String todoCategoryBox = 'todoCategoryBox';
  String todotextBox = 'todotextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(todoCategoryBox);
    box.add(product);
    log("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(todoCategoryBox);
    _categoryList = box.values.toList();
    // calculateTotalPrice();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(todoCategoryBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(todoCategoryBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }

// TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(todotextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(todotextBox);
    _todoList = box.values.toList();
    // print(_todoList);
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(todotextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(todotextBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
