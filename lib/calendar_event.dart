import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

TextEditingController eventController = TextEditingController();

class Event {
  String title;
  Event(this.title);
}

Map<DateTime, List<Event>> events = {};
