
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/task_cubit.dart';
import 'package:to_do_list/screens/home.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => TaskCubit()..getTasks(),
      child: MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white),)),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    ),
  );
}
