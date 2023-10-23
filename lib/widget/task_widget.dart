import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
            padding: EdgeInsets.all(8.0),
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
                  Text(
                    widget.task.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(80, 13, 40, 116),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(
                            width: 2,
                            color: Color.fromARGB(195, 5, 25, 80),
                          )),
                      onPressed: (() {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            backgroundColor: Color.fromARGB(195, 193, 240, 236),
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.task.subTitle,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                      child: Text(
                        'توضیحات',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(195, 5, 25, 80),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(80, 48, 179, 172),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(
                            width: 2,
                            color: Color.fromARGB(195, 3, 95, 60),
                          )),
                      onPressed: (() {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        CircularCountDownTimer(
                                          duration:
                                              int.parse(widget.task.tasktime) *
                                                  60,
                                          initialDuration: 0,
                                          controller: CountDownController(),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          ringColor: Colors.grey[300]!,
                                          ringGradient: null,
                                          fillColor: Colors.green[300]!,
                                          fillGradient: null,
                                          backgroundColor: Colors.teal[800],
                                          backgroundGradient: null,
                                          strokeWidth: 10.0,
                                          strokeCap: StrokeCap.round,
                                          textStyle: TextStyle(
                                              fontSize: 33.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textFormat: CountdownTextFormat.S,
                                          isReverse: false,
                                          isReverseAnimation: false,
                                          isTimerTextShown: true,
                                          autoStart: true,
                                          onStart: () {
                                            debugPrint('Countdown Started');
                                          },
                                          onComplete: () {
                                            debugPrint('Countdown Ended');
                                          },
                                          onChange: (String timeStamp) {
                                            debugPrint(
                                                'Countdown Changed $timeStamp');
                                          },
                                          timeFormatterFunction:
                                              (defaultFormatterFunction,
                                                  duration) {
                                            if (duration.inSeconds == 0) {
                                              return "Start";
                                            } else if (duration.inSeconds > 0 &&
                                                duration.inSeconds <
                                                    int.parse(widget
                                                            .task.tasktime) *
                                                        60) {
                                              return '';
                                            } else if (duration.inSeconds ==
                                                int.parse(
                                                        widget.task.tasktime) *
                                                    60) {
                                              return 'Finish';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                      child: Text(
                        'شروع',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(195, 3, 95, 60),
                        ),
                      ),
                    ),
                  ),
                ],
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
