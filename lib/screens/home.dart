import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/task_cubit.dart';
import 'package:to_do_list/cubit/task_state.dart';
import 'package:to_do_list/screens/add_task.dart';
import 'package:to_do_list/screens/calendar_screen.dart';
import 'package:to_do_list/screens/edit_task.dart';
import 'package:to_do_list/screens/overview_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final filteredTasks = state is TaskSuccessState ? state.filteredTasks() : [];
        if (state is TaskErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(color: Color.fromARGB(255, 33, 89, 243)),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color.fromARGB(255, 33, 89, 243),
            leading: Icon(Icons.checklist_outlined, color: Colors.white, size: 25),
            title: Text(
              'My To-Do List',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    context.read<TaskCubit>().searchTasks(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search your tasks',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_outlined, size: 30),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'All Tasks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff172452),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color.fromARGB(255, 33, 89, 243), width: 2),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: filteredTasks[index].isDone ?? false,
                              checkColor: Colors.white,
                              activeColor: Color.fromARGB(255, 33, 89, 243),
                              side: BorderSide(color: Color.fromARGB(255, 33, 89, 243), width: 2),
                              onChanged: (value) async {
                                filteredTasks[index].isDone = value;
                                await context.read<TaskCubit>().updateTask(filteredTasks[index]);
                              },
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  highlightText(
                                    filteredTasks[index].title,
                                    state is TaskSuccessState ? state.searchText : '',
                                    TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      if (filteredTasks[index].notes != null &&
                                          filteredTasks[index].notes!.isNotEmpty)
                                        highlightText(
                                          filteredTasks[index].notes!,
                                          state is TaskSuccessState ? state.searchText : '',
                                          TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                        ),
                                      if (filteredTasks[index].notes != null &&
                                          filteredTasks[index].notes!.isNotEmpty &&
                                          filteredTasks[index].date != null &&
                                          filteredTasks[index].date!.isNotEmpty)
                                        Text(', '),
                                      if (filteredTasks[index].date != null &&
                                          filteredTasks[index].date!.isNotEmpty)
                                        Text(filteredTasks[index].date!),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: filteredTasks[index].priority == 'High'
                                        ? 56
                                        : filteredTasks[index].priority == 'Medium'
                                            ? 80
                                            : 50,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: filteredTasks[index].priority == 'High'
                                          ? Color.fromARGB(255, 255, 230, 233)
                                          : filteredTasks[index].priority == 'Medium'
                                              ? Color.fromARGB(255, 255, 241, 219)
                                              : Color.fromARGB(255, 225, 232, 255),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      filteredTasks[index].priority ?? '',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: filteredTasks[index].priority == 'High'
                                            ? Color(0xffb91c1c)
                                            : filteredTasks[index].priority == 'Medium'
                                                ? const Color(0xff9a3412)
                                                : Color.fromARGB(255, 33, 89, 243),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final updatedTask = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTaskScreen(task: filteredTasks[index]),
                                  ),
                                );

                                if (updatedTask != null) {
                                  await context.read<TaskCubit>().updateTask(updatedTask);
                                }
                              },
                              icon: Icon(Icons.edit, size: 25),
                            ),
                            IconButton(
                              onPressed: () async {
                                await context.read<TaskCubit>().deleteTask(filteredTasks[index].id ?? 0);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final taskmodel = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
              if (taskmodel != null) {
                await context.read<TaskCubit>().addTask(taskmodel);
              }
            },
            backgroundColor: Color.fromARGB(255, 33, 89, 243),
            child: Icon(Icons.add, color: Colors.white),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (value) {
              if (value == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen()));
              } else if (value == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OverviewScreen()));
              }
            },
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.checklist_outlined, size: 30), label: "All"),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month, size: 30), label: "Calendar"),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined, size: 30), label: "Overview"),
            ],
            selectedItemColor: Color.fromARGB(255, 33, 89, 243),
            unselectedItemColor: Color(0xff60656b),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

Widget highlightText(String textmatch, String searchtext, TextStyle style) {
  int start = textmatch.toLowerCase().indexOf(searchtext.toLowerCase());

  if (searchtext.isEmpty || start == -1) {
    return Text(
      textmatch,
      style: style,
    );
  } else {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: textmatch.substring(0, start)),
          TextSpan(
            text: textmatch.substring(start, start + searchtext.length),
            style: TextStyle(
              color: Color.fromARGB(255, 33, 89, 243),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: textmatch.substring(start + searchtext.length)),
        ],
      ),
    );
  }
}