import 'package:flutter/material.dart';

class Event {
  final UniqueKey id;
  final String title;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightGreen,
    this.isAllDay = false,
  });
}
