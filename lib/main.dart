import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goaltracker/Pages/HomePage.dart';
import 'package:goaltracker/Pages/SearchPage.dart';
import 'package:goaltracker/Pages/SettingPage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:goaltracker/calendar_event.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Goal Tracker';
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (BuildContext context, child) => MaterialApp(
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
      ),
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
  // NavRail 세부요소
  NavigationRailLabelType labelType = NavigationRailLabelType.selected;
  bool showLeading = true;
  bool showTrailing = true;
  double groupAlignment = -0.9;

  int index = 0; //navBar 선택 index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Build Test"),
        //elevation: 1.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ),
              child: NavigationBar(
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: index,
                onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_search_outlined),
                    selectedIcon: Icon(Icons.person_search),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Setting',
                  ),
                ],
              ),
            )
          : null,
      body: HomePage(),
      // Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     if (MediaQuery.of(context).size.width >= 640)
      //       NavigationRail(
      //         groupAlignment: groupAlignment,
      //         selectedIndex: index,
      //         onDestinationSelected: (index) => setState(() {
      //           this.index = index;
      //         }),
      //         labelType: labelType,
      //         leading: showLeading
      //             ? FloatingActionButton(
      //                 elevation: 0,
      //                 onPressed: () {},
      //                 child: const Icon(Icons.add),
      //               )
      //             : const SizedBox(),
      //         trailing: showTrailing
      //             ? IconButton(
      //                 onPressed: () {},
      //                 icon: const Icon(Icons.more_horiz_rounded),
      //               )
      //             : const SizedBox(),
      //         destinations: const [
      //           NavigationRailDestination(
      //             icon: Icon(Icons.home_outlined),
      //             selectedIcon: Icon(Icons.home),
      //             label: Text('Home'),
      //           ),
      //           NavigationRailDestination(
      //             icon: Icon(Icons.person_search_outlined),
      //             selectedIcon: Icon(Icons.person_search),
      //             label: Text('Search'),
      //           ),
      //           NavigationRailDestination(
      //             icon: Icon(Icons.settings_outlined),
      //             selectedIcon: Icon(Icons.settings),
      //             label: Text('Setting'),
      //           ),
      //         ],
      //       ),
      //     Expanded(
      //       child: ListView(children: [
      //         IndexedStack(
      //           index: index,
      //           children: [HomePage(), SearchPage(), SettingPage()],
      //         ),
      //       ]),
      //     ),
      //   ],
      // ),
      // floatingActionButton: MediaQuery.of(context).size.width < 640
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) {
      //               return AlertDialog(
      //                 scrollable: true,
      //                 title: Text("title"),
      //                 content: Padding(
      //                   padding: EdgeInsets.all(10),
      //                   child: TextField(
      //                     controller: eventController,
      //                   ),
      //                 ),
      //                 actions: [
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       events.addAll()
      //                       Navigator.of(context).pop();
      //                     },
      //                     child: Text("Add"),
      //                   )
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //         child: Icon(Icons.add),
      //       )
      //     : null,
    );
  }
}
