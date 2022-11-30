String formatTime(String d, int choice) {
  DateTime formattedTime = DateTime.parse(d).toLocal();
  Duration difference = formattedTime.difference(DateTime.now());
  String timeUntil = "";

  //Difference Logic
  if (difference.inDays.toInt() > 1) {
    timeUntil +=
        "Due in ${formattedTime.difference(DateTime.now()).inDays.toString()} Days";
  } else if (difference.inDays.toInt() == 1) {
    timeUntil += "Due Tomorrow";
  } else if (difference.inMinutes.toInt() > 0) {
    timeUntil += "Due Today";
  } else {
    timeUntil = "PAST DUE";
  }

  if (choice == 0) {
    String timeStringFormat =
        ("$timeUntil\n${formattedTime.month}/${formattedTime.day} @ ${formattedTime.hour}:${formattedTime.minute}");
    return timeStringFormat;
  } else {
    String timeStringFormat = (timeUntil);
    return timeStringFormat;
  }
}

String formatClassName(String c) {
  String formattedClassName = c.substring(24);
  return formattedClassName;
}

String meetingTime(List classinfo, int choice) {
  String beginTime = classinfo[0]["beginTime"];
  String endTime = classinfo[0]["endTime"];
  if (choice == 0) {
    String classTime =
        '${beginTime.substring(0, 2)}:${beginTime.substring(2)}-${endTime.substring(0, 2)}:${endTime.substring(2)}\n';
    List days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
    for (int i = 0; i < days.length; i++) {
      if (classinfo[0][days[i]] == true) {
        if (days[i] == 'thursday') {
          classTime += "${days[i].substring(0, 2).toString().toUpperCase()} ";
        } else {
          classTime += "${days[i].substring(0, 1).toString().toUpperCase()} ";
        }
      }
    }
    return classTime;
  } else {
    String classTime =
        '${beginTime.substring(0, 2)}:${beginTime.substring(2)}-${endTime.substring(0, 2)}:${endTime.substring(2)}\n';
    return classTime;
  }
}

dynamic getTodayClasses(List classinfo, String day) {
  List currentclasses = [];
  for (int i = 0; i < classinfo[0].length; i++) {
    if (classinfo[0][i]["meetingTimes"][0][day.toLowerCase()] == true) {
      currentclasses.add(classinfo[0][i]);
    }
  }
  currentclasses.sort((a, b) => a["meetingTimes"][0]["beginTime"].compareTo(b["meetingTimes"][0]["beginTime"]));
  return currentclasses;
}

dynamic getClasses(List classinfo) {
  List days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
  List currentclasses = [];
  for (int i = 0; i < days.length; i++) {
    List tempSchedule = [];
    for (int j = 0; j < classinfo[0].length; j++) {
      if (classinfo[0][j]["meetingTimes"][0][days[i]] == true) {
        tempSchedule.add(classinfo[0][j]);
      }
      tempSchedule.sort((a, b) => a["meetingTimes"][0]["beginTime"].compareTo(b["meetingTimes"][0]["beginTime"]));
      currentclasses.add(tempSchedule);
    }
  }
  return currentclasses;
}
