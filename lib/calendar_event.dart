import 'package:flutter/foundation.dart';

class Event {
  final String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}
