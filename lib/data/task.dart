import 'package:hive/hive.dart';
import 'package:note/data/task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  Task(
      {required this.title,
      required this.subTitle,
      this.isDone = false,
      required this.taskType,
      required this.time,
      required this.tasktime});

  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;

  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;

  @HiveField(5)
  String tasktime;
}
