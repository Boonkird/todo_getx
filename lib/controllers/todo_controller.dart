import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/core/constant.dart';
import 'package:todo_getx/services/storage_service.dart';

import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  final textEditingController = TextEditingController();
  final subtitleController = TextEditingController();
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchTodos();
  }

  Future<void> addTodo(String title, String text) async {
    try {
      String? uid = authController.user.value?.uid;
      if (uid == null) return;

      TodoModel newTodo = TodoModel(uid: uid, title: title, subtitle: text);
      String docId = await storageService.write(
        Appkey.todoList,
        newTodo.toJson(),
        uid: uid,
      );

      newTodo.docId = docId;
      todoList.add(newTodo);
      todoList.refresh();
    } catch (e) {
      print('TodoController.addTodo : $e');
    }
  }

  Future<void> toggleTodo(String docId, bool isCompelted) async {
    try {
      TodoModel todo = todoList.firstWhere((e) => e.docId == docId);
      todo.isCompelted = isCompelted;
      await storageService.update(Appkey.todoList, docId, todo.toJson());
      todoList.refresh();
    } catch (e) {
      print('StorageService.update: $e');
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    // todoList.firstWhere((todo) => todo.docId == todo.docId).title = todo.title;
    // todoList.firstWhere((todo) => todo.docId == todo.docId).subtitle =
    //     todo.subtitle;
    todoList.refresh();
    await storageService.update(Appkey.todoList, todo.docId, todo.toJson());
    // await storageService.update('todoList', todo.docId ?? '', todo.toJson());
  }

  Future<void> deleteTodo(String docId) async {
    try {
      await storageService.delete(Appkey.todoList, docId);
      todoList.removeWhere((e) => e.docId == docId);
      todoList.refresh();
    } catch (e) {
      print('StorageService.delete: $e');
    }
  }

  Future<void> fetchTodos() async {
    var todos = await storageService.read(
      Appkey.todoList,
      uid: authController.user.value?.uid,
    );
    todoList.value = todos.map((e) => TodoModel.fromJson(e)).toList();
  }
}
