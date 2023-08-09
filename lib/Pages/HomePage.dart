import 'dart:collection';
import 'dart:html';
import 'dart:js';
import 'package:goaltracker/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaltracker/calendar_event.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  // void addEventDialog() {
  //   AlertDialog(
  //     title: Text(
  //       'Add Event',
  //       textAlign: TextAlign.center,
  //     ),
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         TextField(
  //           controller: titleController,
  //           textCapitalization: TextCapitalization.words,
  //           decoration: InputDecoration(
  //             labelText: 'Title',
  //           ),
  //         ),
  //         TextField(
  //           controller: descpController,
  //           textCapitalization: TextCapitalization.words,
  //           decoration: InputDecoration(
  //             labelText: 'Your Plan',
  //           ),
  //         )
  //       ],
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () => Navigator.pop(context as BuildContext),
  //         child: Text('Cancel'),
  //       ),
  //       TextButton(
  //         child: Text('Add'),
  //         onPressed: () {
  //           if (titleController.text.isEmpty && descpController.text.isEmpty) {
  //             ScaffoldMessenger.of(context as BuildContext).showSnackBar(
  //               SnackBar(
  //                 content: Text('내용을 입력해주세요.'),
  //                 duration: Duration(seconds: 2),
  //               ),
  //             );
  //             return;
  //           } else {
  //             if (selectedEvents[selected_day] != null) {
  //               selectedEvents[selected_day]!.add(
  //                 Event(title: titleController.text),
  //               );
  //             } else {
  //               selectedEvents[selected_day] = [
  //                 Event(title: titleController.text)
  //               ];
  //             }
  //             // print(titleController.text);
  //             // print(descpController.text);
  //             Navigator.pop(context as BuildContext);
  //             titleController.clear();
  //             return;
  //           }
  //         },
  //       )
  //     ],
  //   );
  // }

  late final ValueNotifier<List<Event>> selectedEvents;

  @override
  void initState() {
    super.initState();
    selectedEvents = ValueNotifier(getEventsForDay(selected_day));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  DateTime selected_day = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime today = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          //Text("test"),
          TableCalendar(
            locale: 'ko_KR',
            focusedDay: today,
            firstDay: DateTime.utc(2022, 04, 25),
            lastDay: DateTime.utc(2023, 10, 24),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              formatButtonShowsNext: false,
              formatButtonTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize:
                    MediaQuery.of(context).size.width < 640 ? 10.sp : 6.sp,
                fontWeight: FontWeight.normal,
              ),
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMd(locale).format(date),
              titleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize:
                    MediaQuery.of(context).size.width < 640 ? 15.sp : 8.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            calendarStyle: CalendarStyle(
              markersAlignment: Alignment.bottomRight,
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신
              setState(() {
                this.selected_day = selectedDay;
                this.today = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양 변경
              return isSameDay(selected_day, day);
            },
            eventLoader: getEventsForDay,
            calendarFormat: format,
            availableCalendarFormats: const {
              CalendarFormat.month: "한달",
              CalendarFormat.twoWeeks: "2주",
              CalendarFormat.week: "1주"
            },
            formatAnimationCurve: Curves.easeInOutCubic,
            formatAnimationDuration: Duration(milliseconds: 800),
            availableGestures: AvailableGestures.horizontalSwipe,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                this.format = format;
              });
            },
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () => print(""),
                              title: Text('${value[index]}'),
                            ),
                          );
                        });
                  })),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("title"),
                    content: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: eventController,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          events.addAll({
                            selected_day!: [Event(eventController.text)]
                          });
                          Navigator.of(context).pop();
                          //selectedEvents.value = getEventsForDay(selected_day!);
                        },
                        child: Text("Add"),
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ]),
      ),
    );
  }
}
