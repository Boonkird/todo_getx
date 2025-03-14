import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/models/todo_model.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_tile.dart';
import 'add_todo_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการ'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Obx(
        () => Center(
          // ทำให้รายการอยู่กลาง
          child: ListView.builder(
            itemCount: todoController.todoList.length,
            itemBuilder: (context, index) {
              TodoModel todo = todoController.todoList[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TodoTile(
                      todo: todo,
                      onToggle:
                          () => todoController.toggleTodo(
                            todo.docId,
                            !todo.isCompelted,
                          ),
                      onDelete: () {
                        todoController.deleteTodo(todo.docId);
                        Get.snackbar(
                          'Deleted',
                          'Deleted "${todo.title}"',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      subtitle: null,
                      ontap: () {
                        Get.to(() => AddTodoView(todo: todo));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTodoView()), // ไปหน้าเพิ่มรายการ
        child: Icon(Icons.add),
      ),
    );
  }
}
