import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gtd/models/deleteModel.dart';
import 'package:hive/hive.dart';

import '../models/toDoModel.dart';

class DeleteProvider with ChangeNotifier {
  String deleteBox = 'deleteBox';
  String deleteToDoTextBox = 'deleteToDoTextBox';

  List _categoryList = <DeleteModel>[];
  List _todoList = <TodoModel>[];
  List get categoryList => _categoryList;
  List get todoList => _todoList;

  addDeleteItem(DeleteModel product) async {
    var box = await Hive.openBox<DeleteModel>(deleteBox);
    box.add(product);
    log('1 addDeleteItem successful');
    notifyListeners();
  }

  getDeleteItem() async {
    final box = await Hive.openBox<DeleteModel>(deleteBox);
    _categoryList = box.values.toList();
    notifyListeners();
  }

  updateDeleteItem(int index, DeleteModel product) {
    final box = Hive.box<DeleteModel>(deleteBox);

    box.putAt(index, product);

    getDeleteItem();
    notifyListeners();
  }

  deleteDeleteItem(int index) {
    final box = Hive.box<DeleteModel>(deleteBox);
    box.deleteAt(index);
    log('2 Data deleted Succesfully');
    getDeleteItem();

    notifyListeners();
  }
}
