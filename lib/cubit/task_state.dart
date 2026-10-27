import 'package:to_do_list/models/task_model.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskSuccessState extends TaskState {
  final List<TaskModel> tasks;
  final String searchText;
  final String selectedFilter;

  TaskSuccessState({
    required this.tasks,
    this.searchText = '',
    this.selectedFilter = 'All',
  });

  List<TaskModel> filteredTasks() {
    return tasks.where((t) {
      final matchesSearch =
          t.title.toLowerCase().contains(searchText) ||
          (t.notes ?? '').toLowerCase().contains(searchText);

      bool matchesFilter = true;
      if (selectedFilter == 'Completed') {
        matchesFilter = t.isDone == true;
      } else if (selectedFilter == 'Pending') {
        matchesFilter = t.isDone == false || t.isDone == null;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}