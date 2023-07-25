import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
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
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
              ),
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMd(locale).format(date),
              titleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            calendarStyle: CalendarStyle(
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
                  fontWeight: FontWeight.bold),
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
            calendarFormat: format,
            availableCalendarFormats: const {
              CalendarFormat.month: "한달",
              CalendarFormat.twoWeeks: "2주",
              CalendarFormat.week: "1주"
            },
            formatAnimationCurve: Curves.easeInOutCubic,
            formatAnimationDuration: Duration(milliseconds: 800),
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                this.format = format;
              });
            },
          ),
        ]),
      ),
    );
  }
}
