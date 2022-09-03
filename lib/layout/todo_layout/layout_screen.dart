import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/cubit.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/states.dart';
import 'package:todo_application/shared/components/components.dart';

class TodoLayout extends StatelessWidget {
  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDB(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeButtonNav(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  label: 'Tasks',
                  icon: Icon(
                    Icons.task,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Done',
                  icon: Icon(
                    Icons.done,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Archive',
                  icon: Icon(
                    Icons.archive,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isFloating) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertDB(
                            taskName: taskController.text,
                            time: timeController.text,
                            date: dateController.text)
                        .then((value) {
                      Navigator.pop(context);
                      taskController.clear();
                      timeController.clear();
                      dateController.clear();
                      cubit.changeFloating(
                          icon: const Icon(Icons.edit), isShow: false);
                    });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => buildFloatingButton(
                          context,
                          taskController,
                          timeController,
                          dateController,
                          formKey,
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeFloating(
                        icon: const Icon(Icons.edit), isShow: false);
                  });
                  cubit.changeFloating(
                      icon: const Icon(Icons.add), isShow: true);
                }
              },
              child: cubit.iconFloating,
            ),
          );
        },
      ),
    );
  }
}
