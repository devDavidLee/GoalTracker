import 'dart:collection';
import 'dart:html';
import 'dart:js';
import 'package:flutter/services.dart';
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
  Map<DateTime, List<Event>> events = {};
  TextEditingController eventController = TextEditingController();
  late final ValueNotifier<List<Event>> selectedEvents;

  DateTime selected_day = DateTime.now();
  DateTime focused_day = DateTime.now();

  @override
  void initState() {
    super.initState();
    selected_day = focused_day;
    selectedEvents = ValueNotifier(getEventsForDay(selected_day!));
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selected_day, selectedDay)) {
      setState(() {
        selected_day = selectedDay;
        focused_day = focusedDay;
        selectedEvents.value = getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Center(
          child: Column(children: [
            //Text("test"),
            TableCalendar(
              locale: 'ko_KR',
              focusedDay: focused_day,
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
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (DateTime day) {
                // selectedDay 와 동일한 날짜의 모양 변경
                return isSameDay(selected_day, day);
              },
              onPageChanged: (focusedDay) {
                focused_day = focusedDay;
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
              height: 8,
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
                                onTap: () => print('${value[index]}'),
                                title: Text('${value[index]}'),
                              ),
                            );
                          });
                    })),
          ]),
        ),
      ),
      Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton(
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
                      decoration: InputDecoration(
                        hintText: 'Enter event title',
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        events.addAll({
                          selected_day!: [Event(eventController.text)]
                        });
                        selectedEvents.value = getEventsForDay(selected_day!);
                        eventController.clear();
                        Navigator.of(context).pop();
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
      )
    ]);
  }
}
