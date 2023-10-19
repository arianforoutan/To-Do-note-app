import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note/screens/edit_task_screen.dart';

import '../data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return gettaskItem();
  }

  Widget gettaskItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isBoxChecked = !isBoxChecked;
            widget.task.isDone = isBoxChecked;
            widget.task.save();
          });
        },
        child: Container(
          height: 132,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: getRowTaskItem(),
          ),
        ),
      ),
    );
  }

  Widget getRowTaskItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      activeColor: Color(0xff18DAA3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: isBoxChecked,
                      onChanged: ((value) {}),
                    ),
                  ),
                  Text(widget.task.title),
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              getTimeandEditBadgs(),
            ],
          ),
        ),
        SizedBox(width: 15),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Widget getTimeandEditBadgs() {
    return Row(
      children: [
        Container(
          width: 90,
          height: 28,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 54, 221, 213),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${widget.task.time.hour}:${getMinUnder10(widget.task.time)}',
                  style: TextStyle(),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return EditTaskScreen(
                task: widget.task,
              );
            })));
          },
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromARGB(136, 193, 240, 236),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 221, 213),
                      fontFamily: 'SH',
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 16,
                    child: Image.asset('images/icon_edit.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnder10(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
