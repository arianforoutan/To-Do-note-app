import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note/data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItemList})
      : super(key: key);
  TaskType taskType;

  int index;
  int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (selectedItemList == index) ? Color(0xffE2F6F1) : Colors.white,
        border: Border.all(
          width: 3,
          color: (selectedItemList == index)
              ? Color.fromARGB(255, 54, 221, 213)
              : Color.fromARGB(136, 193, 240, 236),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 110,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(taskType.image),
            Text(taskType.title),
          ],
        ),
      ),
    );
  }
}
