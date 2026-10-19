import 'package:flutter/material.dart';
import 'package:to_do_list/models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController = TextEditingController(text: widget.task.title);
  late TextEditingController notesController = TextEditingController(text: widget.task.notes ?? '');
  late String priority = widget.task.priority ?? 'Medium';
  late String date = (widget.task.date == null || widget.task.date!.isEmpty) ? 'Select date' : widget.task.date!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 33, 89, 243),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Task',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task Title',
                     style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      decoration: boxDecoration('Enter task title'),
                    ),
                    SizedBox(height: 20),
                    Text('Notes (optional)',
                     style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: boxDecoration('Add any additional notes...'),
                    ),
                    SizedBox(height: 20),
                    Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: priorityBtn(
                            'Low',
                            priority == 'Low',
                            () => setState(() => priority = 'Low'),
                            Color.fromARGB(255, 33, 89, 243),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: priorityBtn(
                            'Medium',
                            priority == 'Medium',
                            () => setState(() => priority = 'Medium'),
                            Color.fromARGB(255, 33, 89, 243),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: priorityBtn(
                            'High',
                            priority == 'High',
                            () => setState(() => priority = 'High'),
                            Color.fromARGB(255, 33, 89, 243),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Due Date (optional)',
                     style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setState(() {
                            date = "${picked.year}-${picked.month}-${picked.day}";
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color.fromARGB(255, 33, 89, 243),
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                date,
                                style: TextStyle(
                                  color: date == 'Select date'
                                      ? Colors.grey.shade400
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 33, 89, 243),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please enter task title')),
                            );
                            return;
                          }

                          final updatedTask = TaskModel(
                            id: widget.task.id,
                            title: titleController.text,
                            notes: notesController.text,
                            priority: priority,
                            date: date == 'Select date' ? null : date,
                            isDone: widget.task.isDone,
                          );
                          Navigator.pop(context, updatedTask);
                        },
                        child: Text(
                          'Update Task',
                          style: TextStyle(fontSize: 16,
                           fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration boxDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF536DFE), width: 1.5)),
    );
  }

  Widget priorityBtn(String title, bool isSelected, VoidCallback onTap, Color activeColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? activeColor : Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}