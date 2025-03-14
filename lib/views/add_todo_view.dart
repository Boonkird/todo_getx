import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/models/todo_model.dart';
import 'package:todo_getx/widgets/snackbar.dart';

class AddTodoView extends StatefulWidget {
  final TodoController todoController = Get.find();

  AddTodoView({super.key, this.todo});
  TodoModel? todo;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  TodoController todoController = Get.put(TodoController());

  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      subtitleController.text = widget.todo!.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'ชื่อรายการ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: subtitleController,
                decoration: InputDecoration(
                  labelText: 'รายละเอียด',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;
                if (widget.todo != null) {
                  widget.todo!.title = titleController.text;
                  widget.todo!.subtitle = subtitleController.text;
                  todoController.updateTodo(widget.todo!);
                  print(widget.todo!.toJson());
                  Get.back();
                  MySnackbar.showSnackbar(
                    title: 'Updated',
                    message: 'Todo updated successfully!',
                  );
                  return;
                } else {
                  todoController.addTodo(
                    titleController.text,
                    subtitleController.text,
                  );
                  Get.back();
                  MySnackbar.showSnackbar(
                    title: 'Added',
                    message: 'Todo added successfully!',
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // สีข้อความของปุ่ม
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ), // ขนาด padding ของปุ่ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // รูปร่างของปุ่ม
                ),
              ),
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
