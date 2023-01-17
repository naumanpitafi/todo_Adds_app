import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:hive_flutter/hive_flutter.dart';


class InboxProvider with ChangeNotifier {
  String inboxToDoTextBox = 'inboxToDoTextBox';

  List _todoList = <InboxModel>[];
  List get todoList => _todoList;

  // TODO WORK

  addTODOItem(InboxModel product) async {
    var box = await Hive.openBox<InboxModel>(inboxToDoTextBox);
    box.add(product);
    log("Added");
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<InboxModel>(inboxToDoTextBox);
    _todoList = box.values.toList();
    notifyListeners();
  }

  updateTODOItem(int index, InboxModel product) {
    final box = Hive.box<InboxModel>(inboxToDoTextBox);

    box.putAt(index, product);
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<InboxModel>(inboxToDoTextBox);
    box.deleteAt(index);

    notifyListeners();
  }
}
