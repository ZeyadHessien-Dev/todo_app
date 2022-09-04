import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/layout/todo_layout/layout_cubit/cubit.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  required TextInputType keyboardType,
  IconButton? suffixIcon,
  ValueChanged<String>? onFieldSubmitted,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  GestureTapCallback? onTap,
  bool obscureText = false,
  Key? key,
}) =>
    TextFormField(
      key: key,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 40,
  double radius = 10.0,
  Color color = Colors.blue,
  required VoidCallback? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget divideBy() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => true,
  );
}

Widget buildFloatingButton(
  context,
  taskController,
  timeController,
  dateController,
  formKey,
  taskTextFormFieldKey,
  timeTextFormFieldKey,
  dateTextFormFieldKey,
) =>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextForm(
              key: taskTextFormFieldKey,
              controller: taskController,
              labelText: 'Task',
              prefixIcon: Icons.task,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                taskTextFormFieldKey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Task Must Not Be Empty';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            defaultTextForm(
              key: timeTextFormFieldKey,
              controller: timeController,
              labelText: 'Time',
              prefixIcon: Icons.watch_later_outlined,
              keyboardType: TextInputType.text,
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  // TO Validate
                  timeController.text = value!.format(context).toString();
                  timeTextFormFieldKey.currentState!.validate();
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Time Must Not Be Empty';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            defaultTextForm(
              key: dateTextFormFieldKey,
              controller: dateController,
              labelText: 'Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.parse(
                    '2022-12-16',
                  ),
                ).then((value) {
                  dateController.text = DateFormat.yMMMd().format(value!);
                  // TO Validate
                  dateTextFormFieldKey.currentState!.validate();
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Date Must Not Be Empty';
                }
              },
            ),
          ],
        ),
      ),
    );

Widget buildItems(context, Map item, index) => Dismissible(
      key: Key(item['id'].toString()),
      onDismissed: (direction) {
        TodoCubit.get(context).deleteDB(id: item['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              child: Text(
                item['time'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['taskName'],
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item['date'],
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                TodoCubit.get(context).updateDB(status: 'done', id: item['id']);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                TodoCubit.get(context)
                    .updateDB(status: 'archive', id: item['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );



Widget buildListItem(context, cubit) => cubit.isNotEmpty
    ? ListView.separated(
        itemBuilder: (context, index) =>
            buildItems(context, cubit[index], index),
        separatorBuilder: (context, index) => divideBy(),
        itemCount: cubit.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100,
            ),
            Text(
              'No Tasks Here, Write Your Task Now ...',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
