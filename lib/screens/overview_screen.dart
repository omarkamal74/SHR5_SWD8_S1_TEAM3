import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/task_cubit.dart';
import 'package:to_do_list/cubit/task_state.dart';
import 'package:to_do_list/models/task_model.dart';
import 'package:to_do_list/screens/calendar_screen.dart';
import 'package:to_do_list/screens/home.dart';

import '../widgets/stats_section.dart';
import '../widgets/filter_section.dart';
import '../widgets/overview_task_item_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 33, 89, 243),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, color: Colors.white, size: 28),
            //SizedBox(width: 10),
            Text(
              'Tasks Overview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TaskErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final List<TaskModel> allTasks = state is TaskSuccessState
              ? state.tasks
              : [];

          final String currentFilter = state is TaskSuccessState
              ? state.selectedFilter
              : 'All';

          final List<TaskModel> filteredTasks = state is TaskSuccessState
              ? state.filteredTasks()
              : [];

          int totalTasks = allTasks.length;
          int completedTasks = allTasks.where((t) => t.isDone == true).length;
          int pendingTasks = totalTasks - completedTasks;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatsSection(
                  totalTasks: totalTasks,
                  completedTasks: completedTasks,
                  pendingTasks: pendingTasks,
                ),
                SizedBox(height: 24),

                FilterSection(selectedFilter: currentFilter),
                SizedBox(height: 24),

                Text(
                  'Tasks (${filteredTasks.length})',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    return TaskItemCard(
                      task: task,
                      onChanged: (bool? value) async {
                        task.isDone = value;
                        await context.read<TaskCubit>().updateTask(task);
                      },
                      onDeleted: () async {
                        if (task.id != null) {
                          await context.read<TaskCubit>().deleteTask(task.id!);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarScreen()),
            );
          }
        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined, size: 30),
            label: "All",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 30),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, size: 30),
            label: "Overview",
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 33, 89, 243),
        unselectedItemColor: Color(0xff60656b),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}