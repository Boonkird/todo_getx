import 'package:get/get.dart';
import 'package:todo_getx/services/storage_service.dart';
import '../models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoController extends GetxController {
  var todolist = <TodoModel>[].obs;
  StorageService storageService = StorageService();
  final textEditingController = TextEditingController();
  final subtitleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    var todos = await storageService.read('todoList');
    if (todos != null) {
      todolist.value = List<TodoModel>.from(
        todos.map((x) => TodoModel.fromJson(x)),
      );
    }
  }

  void addTodo() {
    String title = textEditingController.text;
    String subtitle = subtitleController.text;
    todolist.add(TodoModel(title: title, subtitle: subtitle));
    textEditingController.clear();
    subtitleController.clear();
  }

  void toggleTodo(int index) {
    todolist[index].isDone = !todolist[index].isDone;
    todolist.refresh();
    storageService.write('todoList', todolist.toJson());
  }

  void deleteTodo(int index) {
    todolist.removeAt(index);
  }
}
