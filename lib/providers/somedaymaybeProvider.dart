import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/categoryModel.dart';
import '../models/toDoModel.dart';

class SomeDayMaybeProvider with ChangeNotifier {
  String somedayMybeBox = 'somedayMybeBox';
  String somedayMaybeToDoTextBox = 'somedayMaybeToDoTextBox';

  List _categoryList = <CategoryModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addCategory(CategoryModel product) async {
    var box = await Hive.openBox<CategoryModel>(somedayMybeBox);
    box.add(product);
    log("Added");
    notifyListeners();
  }

  getCategory() async {
    final box = await Hive.openBox<CategoryModel>(somedayMybeBox);
    _categoryList = box.values.toList();
    notifyListeners();
  }

  updateCategory(int index, CategoryModel product) {
    final box = Hive.box<CategoryModel>(somedayMybeBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteCartItem(int index) {
    final box = Hive.box<CategoryModel>(somedayMybeBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }


  
  // TODO WORK

  addTODOItem(TodoModel product) async {
    var box = await Hive.openBox<TodoModel>(somedayMaybeToDoTextBox);
    box.add(product);

    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<TodoModel>(somedayMaybeToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, TodoModel product) {
    final box = Hive.box<TodoModel>(somedayMaybeToDoTextBox);

    box.putAt(index, product);

    getCategory();
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<TodoModel>(somedayMaybeToDoTextBox);
    box.deleteAt(index);
    getCategory();

    notifyListeners();
  }
}
