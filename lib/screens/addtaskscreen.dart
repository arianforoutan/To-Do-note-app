import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/screens/home_screen.dart';

import 'package:note/data/task_type.dart';

import 'package:note/utility/utility.dart';
import 'package:note/widget/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final box = Hive.box<Task>('taskbox');

  DateTime? _time;

  int _selectedTaskTypeItem = 0;

  FocusNode negahdar1 = FocusNode();
  FocusNode negahdar2 = FocusNode();

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTasksubtitle = TextEditingController();

  @override
  void initState() {
    negahdar1.addListener(() {
      setState(() {});
    });

    negahdar2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahdar1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: negahdar1.hasFocus
                            ? Color.fromARGB(255, 54, 221, 213)
                            : Color.fromARGB(255, 21, 151, 211),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 151, 211),
                          width: 3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color.fromARGB(255, 54, 221, 213),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: controllerTasksubtitle,
                    maxLines: 2,
                    focusNode: negahdar2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      labelText: 'توضیحات تسک',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: negahdar2.hasFocus
                            ? Color.fromARGB(255, 54, 221, 213)
                            : Color.fromARGB(255, 21, 151, 211),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 21, 151, 211),
                          width: 3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color.fromARGB(255, 54, 221, 213),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 54, 221, 213),
                      fontWeight: FontWeight.bold),
                  positiveButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 54, 221, 213),
                      fontWeight: FontWeight.bold),
                  titleStyle: TextStyle(
                      color: Color.fromARGB(255, 54, 221, 213),
                      fontWeight: FontWeight.bold),
                  title: ' زمان تسک را انتخاب کنید',
                  negativeButtonText: 'حذف ',
                  positiveButtonText: 'تایید',
                  elevation: 0,
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeItem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItemList: _selectedTaskTypeItem,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 40),
                  backgroundColor: Color.fromARGB(255, 54, 221, 213),
                ),
                onPressed: () {
                  var taskTitle = controllerTaskTitle.text;
                  var tasksubTitle = controllerTasksubtitle.text;
                  addTask(taskTitle, tasksubTitle);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return HomeScreen();
                      }),
                    ),
                  );
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTask(String taskTitle, String tasksubTitle) {
    var task = Task(
        title: taskTitle,
        subTitle: tasksubTitle,
        time: _time!,
        tasktime: 10,
        taskType: getTaskTypeList()[_selectedTaskTypeItem]);

    box.add(task);
  }
}
