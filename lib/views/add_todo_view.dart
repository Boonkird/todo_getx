import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/widgets/snackbar.dart';

class AddTodoView extends StatelessWidget {
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการ'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoController.textEditingController,
              decoration: InputDecoration(
                labelText: 'ชื่อรายการ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: todoController.subtitleController,
                decoration: InputDecoration(
                  labelText: 'รายละเอียด',
                  border: OutlineInputBorder(),
                ),
                maxLines: null, // ทำให้กล่องรายละเอียดสามารถขยายได้ตามเนื้อหา
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (todoController.textEditingController.text.isNotEmpty) {
                  todoController.addTodo();
                  Get.back();
                  MySnackbar.showSnackbar(
                    title: 'Added',
                    message: 'Todo added successfully!',
                  );
                }
              },
              child: Text('เพิ่มรายการ'),
            ),
          ],
        ),
      ),
    );
  }
}
