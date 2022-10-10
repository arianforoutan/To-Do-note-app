import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note/screens/addtaskscreen.dart';
import 'package:note/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/data/task_type.dart';
import 'data/task.dart';
import 'data/type_enum.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

  await Hive.openBox<Task>('taskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SH',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'SH',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
