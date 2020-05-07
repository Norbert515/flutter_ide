import 'package:flutter/material.dart';

class WOffset extends Offset {

  const WOffset({double dx = 0, double dy = 0}) : super(dx, dy);

}

class WDuration extends Duration {

  const WDuration({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliseconds = 0,
    this.microseconds = 0
  }): super(
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
    microseconds: microseconds,
  );

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final int microseconds;



}