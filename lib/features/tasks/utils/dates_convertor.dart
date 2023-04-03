import 'package:flutter/material.dart';

abstract class DatesConvertor {
static String convertTimeOfDay(TimeOfDay time){
  return '${time.hour} : ${time.minute}';
}

static String convertDateTime(DateTime date){
  return '${date.day}.${date.month}.${date.year}';
}
}