import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityTimer extends StatefulWidget {
  const ActivityTimer(
      {super.key, required this.points, required this.handleActivityFinish});

  final String points;
  final Function handleActivityFinish;

  @override
  ActivityTimerState createState() => ActivityTimerState();
}

class ActivityTimerState extends State<ActivityTimer> {
  Timer? _timer;
  FToast? fToast;

  int durationSeconds = 0;
  int warningStartAtSeconds = 60;
  bool isNearOutOfTime = false;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  void startTimer() {
    const second = Duration(seconds: 1);
    _timer?.cancel();

    setState(() {
      durationSeconds = 60;
    });

    _timer = Timer.periodic(second, (Timer timer) {
      if (durationSeconds == 0) {
        setState(() {
          widget.handleActivityFinish();
          timer.cancel();
        });
      } else {
        setState(() {
          if (warningStartAtSeconds >= durationSeconds) {
            if (!isNearOutOfTime) {
              showToast();
              isNearOutOfTime = true;
            }
          }
          durationSeconds--;
        });
      }
    });
  }

  void showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning, color: Colors.white),
          SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Warning: You have 60 seconds left",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Click me to disappear",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      isDismissable: true,
      gravity: ToastGravity.BOTTOM_LEFT,
      fadeDuration: const Duration(milliseconds: 300),
      toastDuration: const Duration(seconds: 30),
    );
  }

  @override
  void initState() {
    durationSeconds = 63;
    startTimer();
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast!.init(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.points} points",
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            Text(
              formatTime(durationSeconds),
              style: TextStyle(
                  color: isNearOutOfTime ? Colors.red : Colors.black,
                  fontSize: 18,
                  letterSpacing: 3),
            ),
            Text(
              " left",
              style: TextStyle(
                color: isNearOutOfTime ? Colors.red : Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}
