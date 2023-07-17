import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Goal Tracker';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  DateTime selected_day = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime today = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("GoalTracker")),
        body: Container(
          child: Center(
            child: Column(children: [
              Text("test"),
              TableCalendar(
                locale: 'ko_KR',
                focusedDay: today,
                firstDay: DateTime.utc(2022, 04, 25),
                lastDay: DateTime.utc(2023, 10, 24),
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  formatButtonShowsNext: false,
                  formatButtonTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                  titleCentered: false,
                  titleTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신합니다.
                  setState(() {
                    this.selected_day = selectedDay;
                    this.today = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                  return isSameDay(selected_day, day);
                },
                calendarFormat: format,
                onFormatChanged: (CalendarFormat format) {
                  setState(() {
                    this.format = format;
                  });
                },
              ),
            ]),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          // labelBehavior: labelBehavior,
          // selectedIndex: currentPageIndex,
          // onDestinationSelected: (int index) {
          //   setState(() {
          //     currentPageIndex = index;
          //   });
          // },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.commute),
              label: 'Commute',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            ),
          ],
        ));
  }
}
