import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/widgets/snackbar.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_tile.dart';
import 'add_todo_view.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการ'), backgroundColor: Colors.blue),
      body: Obx(
        () => Center(
          // ทำให้รายการอยู่กลาง
          child: ListView.builder(
            itemCount: todoController.todolist.length,
            itemBuilder: (context, index) {
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
                      todo: todoController.todolist[index],
                      onToggle: () => todoController.toggleTodo(index),
                      onDelete: () {
                        todoController.deleteTodo(index);
                        MySnackbar.showSnackbar(
                          title: 'Deleted',
                          message: 'Todo deleted successfully!',
                        );
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
