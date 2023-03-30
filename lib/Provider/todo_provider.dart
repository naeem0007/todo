import 'package:flutter/material.dart';
import 'package:todo/Model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<ToDoModel> _todoList = [];

  List<ToDoModel> get allTodoList => _todoList;

  void addTodoList(ToDoModel toDoModel) {
    _todoList.add(toDoModel);
    notifyListeners();
  }

  void todoStatusChanged(ToDoModel toDoModel) {
    final index = _todoList.indexOf(toDoModel);
    _todoList[index].toggleComplete();
    notifyListeners();
  }

  void removetodoList(ToDoModel toDoModel) {
    final index = _todoList.indexOf(toDoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
}
