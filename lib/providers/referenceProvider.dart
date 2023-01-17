import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/categoryModel.dart';
import '../models/toDoModel.dart';

class ReferenceProvider with ChangeNotifier {
  String referenceBox = 'referenceBox';
  String referenceToDoTextBox = 'referenceToDoTextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(referenceBox);
    box.add(product);
    log("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(referenceBox);
    _categoryList = box.values.toList();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(referenceBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(referenceBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }



  
  // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(referenceToDoTextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(referenceToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(referenceToDoTextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(referenceToDoTextBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
