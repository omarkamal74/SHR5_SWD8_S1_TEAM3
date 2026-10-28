import 'package:flutter/material.dart';
import 'package:to_do_list/models/task_model.dart';


class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final notesController = TextEditingController();
    final priority = ValueNotifier<String>('Low');
    final date = ValueNotifier<String>('Select date');

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor:  Color.fromARGB(255, 33, 89, 243),
        title: Text(
          'Add Task',
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
                    Text('Task Title ', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),

                    TextField(controller: titleController, decoration: boxDeco('Enter task title')),
                    SizedBox(height: 20),

                    Text('Notes (optional)', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),

                    TextField(controller: notesController,
                     maxLines: 4,
                     decoration: boxDeco('Add any additional notes...')),
                    SizedBox(height: 20),

                    Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    ValueListenableBuilder<String>(
                      valueListenable: priority,
                      builder: (context, val, _) => Row(
                        children: [
                          Expanded(child: prioBtn('Low', val == 'Low',
                           () => priority.value = 'Low', Color.fromARGB(255, 33, 89, 243))),
                           SizedBox(width: 10),

                          Expanded(child: prioBtn('Medium', val == 'Medium',
                           () => priority.value = 'Medium', Color.fromARGB(255, 33, 89, 243))),
                          SizedBox(width: 10),

                          Expanded(child: prioBtn('High', val == 'High',
                           () => priority.value = 'High', Color.fromARGB(255, 33, 89, 243))),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Text('Due Date (optional)', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),

                    ValueListenableBuilder<String?>(
                      valueListenable: date,
                      builder: (context, val, _) => GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(),
                           firstDate: DateTime(2023), lastDate: DateTime(2030));
                          if (picked != null) date.value = "${picked.year}-${picked.month}-${picked.day}";
                        },
                        child: Container(padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.white,
                           borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300)),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                               color: Color.fromARGB(255, 33, 89, 243), size: 20),
                               SizedBox(width: 12),

                              Expanded(child: Text(val ?? 'Select date',
                               style: TextStyle(color: val == 'Select date' ? Colors.grey.shade400 : Colors.black87))),
                              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 33, 89, 243),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                        onPressed: () async{
                         
                          if (titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter task title')),
                            );
                            return;
                          }
                           final taskmodel = TaskModel(title: titleController.text,notes: notesController.text,
                            priority: priority.value, date: date.value == 'Select date' ? '' : date.value);
                         
                          Navigator.pop(context,taskmodel);
                        },
                        child: const Text('Save Task',
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white),

                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                         color: Colors.black87)),
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

  InputDecoration boxDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(16),

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
       borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
       borderSide: BorderSide(color: Colors.grey.shade300)),

      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
       borderSide: BorderSide(color: Color(0xFF536DFE), width: 1.5)),
    );
  }

  Widget prioBtn(String title, bool isSelected, VoidCallback onTap, Color activeColor)
   {return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? activeColor : Colors.grey.shade300),
        ),
        child: Text(title, 
        style: TextStyle(color: isSelected ? Colors.white : Colors.black87,
         fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }
}
