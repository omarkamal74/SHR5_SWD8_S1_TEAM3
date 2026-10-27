import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/database/task_database.dart';
import 'package:to_do_list/models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitialState());

  final DatabaseHelper db = DatabaseHelper();

  List<TaskModel> tasks = [];
  String searchText = '';
  String selectedFilter = 'All';

  Future<void> getTasks() async {
    emit(TaskLoadingState());

    try {
      tasks = await db.get_tasks();

      emit(TaskSuccessState(tasks: tasks, searchText: searchText));
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  void searchTasks(String value) {
    searchText = value.toLowerCase();

    emit(TaskSuccessState(tasks: tasks, searchText: searchText));
  }

  Future<void> addTask(TaskModel taskmodel) async {
    final id = await db.insert_task(taskmodel);
    taskmodel.id = id;

    tasks.add(taskmodel);

    emit(TaskSuccessState(tasks: tasks, searchText: searchText));
  }

  Future<void> deleteTask(int id) async {
    await db.delete_task(id);

    tasks.removeWhere((t) => t.id == id);

    emit(TaskSuccessState(tasks: tasks, searchText: searchText));
  }

  Future<void> updateTask(TaskModel taskmodel) async {
    await db.update_task(taskmodel);
    emit(TaskSuccessState(tasks: tasks, searchText: searchText));
  }

  void changeFilter(String text) {
    selectedFilter = text;
    emit(TaskSuccessState(tasks: tasks, searchText: searchText,selectedFilter: selectedFilter,));
  }
}