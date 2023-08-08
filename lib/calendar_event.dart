import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

// Map<DateTime, dynamic> eventSource = {
//   DateTime(2023, 1, 3): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 5): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 8): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 11): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 13): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 15): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 18): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 1, 20): [
//     Event('운동하기', false),
//   ],
//   DateTime(2023, 8, 8): [
//     Event('운동하기', false),
//   ]
// };

// class Event {
//   final String title;
//   bool complete;
//   Event(this.title, this.complete);

//   @override
//   String toString() => title;
// }

class Event {
  String title;

  Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<Event>? selectedEvents;
final events = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay, hashCode: getHashCode)
  ..addAll({
    DateTime.utc(2023, 08, 07): [Event('hi')],
    DateTime.utc(2023, 08, 23): [Event('hi')]
  });
