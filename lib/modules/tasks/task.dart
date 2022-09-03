import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/cubit.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/states.dart';

import '../../shared/components/components.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context).task;
        return buildListItem(context, cubit);
      },
    );
  }
}
