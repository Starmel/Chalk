class TimeUtil {
  static String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
