import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/layout/todo_layout/layout_screen.dart';
import 'package:todo_application/shared/bloc_observer.dart';
import 'package:todo_application/shared/style/theme.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: TodoLayout(),
    );
  }
}

