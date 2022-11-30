import 'package:flutter/material.dart';
import 'package:myiit/assignments.dart';
import 'package:myiit/schedule.dart';
import 'package:myiit/search.dart';
import 'package:myiit/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'iitapp',
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const SchedulePage(),
    const AssignmentPage(),
    const SearchPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Image(
          image: AssetImage("assets/header.png"),
          width: 160,
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          selectedIndex: pageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_month),
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Schedule',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.assignment),
              icon: Icon(Icons.assignment_outlined),
              label: 'Assignments',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            )
          ]),
      body: pages[pageIndex],
    );
  }
}
