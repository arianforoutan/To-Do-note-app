import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note/screens/addtaskscreen.dart';
import 'package:note/widget/task_widget.dart';

import '../data/task.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputtext = '';
  var controler = TextEditingController();

  var taskBox = Hive.box<Task>('taskbox');

  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('planning'),
        backgroundColor: Color.fromARGB(255, 54, 221, 213),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return AddTaskScreen();
                }),
              ),
            );
          },
          child: Image.asset('images/icon_add.png'),
          backgroundColor: Color.fromARGB(255, 54, 221, 213),
        ),
      ),
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: ((context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                setState(() {
                  if (notification.direction == ScrollDirection.forward) {
                    isFabVisible = true;
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    isFabVisible = false;
                  }
                });

                return true;
              },
              child: ListView.builder(
                itemCount: taskBox.values.length,
                itemBuilder: ((context, index) {
                  var task = taskBox.values.toList()[index];
                  return getListTask(task);
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getListTask(Task task) {
    return Dismissible(
      onDismissed: (direction) {
        task.delete();
      },
      key: UniqueKey(),
      child: TaskWidget(task: task),
    );
  }
}
