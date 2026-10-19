import 'package:flutter/material.dart';
import 'package:to_do_list/models/task_model.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDeleted;

  const TaskItemCard({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = task.isDone ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(35),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Color(0xFF536DFE),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        value: isCompleted,
        onChanged: onChanged,
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: isCompleted ? Colors.grey : Colors.black,
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: (task.notes != null && task.notes!.isNotEmpty)
            ? Text(task.notes!)
            : null,
        secondary: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDeleted,
        ),
      ),
    );
  }
}