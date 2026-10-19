import 'package:to_do_list/models/task_model.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskSuccessState extends TaskState {
  final List<TaskModel> tasks;
  final String searchText;

  TaskSuccessState({required this.tasks,this.searchText = '',});

  get selectedFilter => null;

  List<TaskModel> filteredTasks() {
    return tasks.where((t) {
      return t.title.toLowerCase().contains(searchText) ||
          (t.notes ?? '').toLowerCase().contains(searchText);
    }).toList();
  }
  }

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}
