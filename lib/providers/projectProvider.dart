import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/categoryModel.dart';
import '../models/toDoModel.dart';

class ProjectListProvider with ChangeNotifier {
  String projectListBox = 'projectListBox';
  String projectListToDoTextBox = 'projectListToDoTextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(projectListBox);
    box.add(product);
    print("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(projectListBox);
    _categoryList = box.values.toList();
    // calculateTotalPrice();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(projectListBox);

    box.putAt(index, product);

    getCategory();
    // totalPrice = 0;
    // calculateTotalPrice();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(projectListBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }



  
  // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(projectListToDoTextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(projectListToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(projectListToDoTextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(projectListToDoTextBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
