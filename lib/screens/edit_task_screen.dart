import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:note/screens/home_screen.dart';

import 'package:note/data/task_type.dart';

import 'package:note/utility/utility.dart';
import 'package:note/widget/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final box = Hive.box<Task>('taskbox');

  FocusNode negahdar1 = FocusNode();
  FocusNode negahdar2 = FocusNode();
  FocusNode negahdar3 = FocusNode();

  int _selectedTaskTypeItem = 0;

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTasksubtitle;
  TextEditingController? controllerTasktime;
  DateTime? _time;

  @override
  void initState() {
    super.initState();
    controllerTaskTitle = TextEditingController(text: widget.task.title);

    controllerTasksubtitle = TextEditingController(text: widget.task.subTitle);
    controllerTasktime = TextEditingController(text: widget.task.tasktime);

    negahdar1.addListener(() {
      setState(() {});
    });

    negahdar2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    _selectedTaskTypeItem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                            width: 3, color: Color.fromARGB(255, 54, 221, 213)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 20),
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
                            width: 3, color: Color.fromARGB(255, 54, 221, 213)),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerTasktime,
                    maxLines: 1,
                    focusNode: negahdar3,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      labelText: 'مدت زمان',
                      hintText: 'به دقیقه',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                  var tasktime = controllerTasktime!.text;
                  var taskTitle = controllerTaskTitle!.text;
                  var tasksubTitle = controllerTasksubtitle!.text;
                  editTask(taskTitle, tasksubTitle, tasktime);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return HomeScreen();
                  })));
                },
                child: Text(
                  ' ویرایش تسک',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  editTask(String taskTitle, String tasksubTitle, String tasktime) {
    widget.task.title = taskTitle;
    widget.task.subTitle = tasksubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];
    widget.task.tasktime = tasktime;
    widget.task.save();
  }
}
