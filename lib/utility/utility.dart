import 'package:note/data/task_type.dart';

import '../data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'images/social_frends.jpg',
        title: 'hang out',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        image: 'images/meditate.jpg',
        title: 'focus',
        taskTypeEnum: TaskTypeEnum.focus),
    TaskType(
        image: 'images/hard_working.jpg',
        title: 'working',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'images/banking.jpg',
        title: 'economic',
        taskTypeEnum: TaskTypeEnum.economic),
    TaskType(
        image: 'images/sport.jpg',
        title: 'sport',
        taskTypeEnum: TaskTypeEnum.sport)
  ];

  return list;
}
