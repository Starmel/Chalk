import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_tracker/app/util/TimeUtil.dart';

class TimerLabel extends StatefulWidget {
  const TimerLabel({
    Key key,
    @required this.elapsedTime,
    @required this.isRunning,
  }) : super(key: key);

  final int elapsedTime;
  final bool isRunning;

  @override
  TimerLabelState createState() => TimerLabelState();
}

class TimerLabelState extends State<TimerLabel> {
  int countedTime = 0;
  Timer timer;

  TimerLabelState();

  @override
  Widget build(BuildContext context) {
    resumeOrPauseTimerTicks(widget.isRunning);
    return Expanded(
      child: Text(
        TimeUtil.formatTime(countedTime + widget.elapsedTime),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 46,
          color: Colors.white,
          fontFamily: "Ds-digital",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void resumeOrPauseTimerTicks(bool isRunning) {
    if (timer != null) {
      timer.cancel();
    }

    if (isRunning) {
      timer = Timer(Duration(seconds: 1), () {
        countedTime += 1;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }

    super.dispose();
  }
}
