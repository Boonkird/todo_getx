import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  TodoTile({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: onToggle,
      ),
      title: Text(todo.title),
      subtitle: Text(todo.subtitle), // แสดง subtitle ใต้ title
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
    );
  }
}
