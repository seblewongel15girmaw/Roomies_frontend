
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

void scrollToBottom(dynamic controller) {
  if (controller.hasClients) {
    
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      });
    });
  }
  
}


String formatTime(String dateString, String placement) {
  DateTime givenTime = DateTime.parse(dateString);
  DateTime now = DateTime.now();
  Duration difference = now.difference(givenTime);
  if(placement=="inchat"){
    return DateFormat('hh:mm a').format(givenTime);
  }
  else{

  if (difference.inHours < 24) {
    // If within 24 hours, return time in AM/PM format
    return DateFormat('hh:mm a').format(givenTime);
  } else {
    // If beyond 24 hours, return date with month
    return DateFormat('MMM dd').format(givenTime);
  }
  }
}