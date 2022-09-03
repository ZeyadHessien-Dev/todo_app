import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/states.dart';
import '../../../modules/archive/archive.dart';
import '../../../modules/done/done.dart';
import '../../../modules/tasks/task.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(IniliazteTodoState());

  static TodoCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen = [TaskScreen(), DoneScreen(), ArchiveScreen()];

  Icon iconFloating = const Icon(Icons.edit);
  bool isFloating = false;

  void changeFloating({
    required Icon icon,
    required bool isShow,
  }) {
    iconFloating = icon;
    isFloating = isShow;
    emit(ChangeFloatingIconState());
  }

  void changeButtonNav(index) {
    currentIndex = index;
    emit(ChangeButtonNavigatorState());
  }

  // DataBase
  late Database database;


  List<Map> task = [];
  List<Map> done = [];
  List<Map> archive = [];

  void createDB() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        await database
            .execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, taskName TEXT, time TEXT, date TEXT, status TEXT)')
            .then((value) {
          print('Table Created Successfully');
        });
      },
      onOpen: (database) {
        print('Data Base IS Opened');
        getDB(database);
        emit(CreateDBState());
      },
    );
  }

  Future<void> insertDB({
    required String taskName,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Task(taskName, time, date, status) VALUES("$taskName", "$time", "$date", "new")')
          .then((value) {
        print('$value Inserting Successfully');
      });
    },
    ).then((value) {
      emit(InsertDBState());
      getDB(database);
    });
  }

  void getDB(database) async  {
    await database.rawQuery('SELECT * FROM Task').then((value) {
      task = [];
      done = [];
      archive = [];
      value.forEach((element) {
        if (element['status'] == 'new') {
          task.add(element);
        }
        else if (element['status'] == 'done') {
          done.add(element);
        }
        else if (element['status'] == 'archive') {
          archive.add(element);
        }
      });
      emit(GetDBState());
    });

  }

  void updateDB({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE Task SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(UpdateDBState());
      getDB(database);
    });
  }

  void deleteDB({required int id}) async {
    await database.rawDelete('DELETE FROM Task WHERE id = ?', [id]).then((value) {
      emit(DeleteDBState());
      getDB(database);
    });
  }
}

