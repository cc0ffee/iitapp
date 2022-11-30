import 'package:myiit/services/collection.dart';
import 'package:flutter/material.dart';
import 'package:myiit/services/format.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getTopAssignments =
      Future.delayed(const Duration(seconds: 1), () => readAssignments());
  Future<List> getCurrentClasses =
      Future.delayed(const Duration(seconds: 1), () => readSchedule());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
            child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 24),
                ))),
        Card(
          margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Upcoming Assignments",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder<List>(
                      future: getTopAssignments,
                      builder: (context, AsyncSnapshot<List> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            children = <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount:
                                      (snapshot.data!.length >= 2) ? 2 : 1,
                                  itemBuilder: ((context, index) {
                                    return Card(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: ListTile(
                                            title: Text(
                                                snapshot.data![index]["title"]),
                                            trailing: Text(formatTime(
                                                    snapshot.data![index]
                                                        ["endDate"],
                                                    1)
                                                .toString())));
                                  })),
                            ];
                            if (snapshot.data!.length > 2) {
                              children.add(Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                    '+${snapshot.data!.length - 2} assignment${(snapshot.data!.length - 2 == 1) ? '' : 's'}',
                                    style: const TextStyle(fontSize: 18)),
                              ));
                            }
                          } else {
                            children = <Widget>[
                              const Text.rich(TextSpan(
                                  text: '(_ _ ") .. Zzzz',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300))),
                              const Text.rich(TextSpan(
                                  text: 'No assignments!',
                                  style: TextStyle(fontSize: 18))),
                            ];
                          }
                        } else if (snapshot.hasError) {
                          children = const <Widget>[
                            Icon(Icons.error_outline,
                                color: Colors.red, size: 30),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Error occured'),
                            ),
                          ];
                        } else {
                          children = const <Widget>[
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Loading assignments'),
                            ),
                          ];
                        }
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ));
                      }),
                ]),
          ),
        ),
        Card(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Today's Schedule",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder<List>(
                      future: getCurrentClasses,
                      builder: (context, AsyncSnapshot<List> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          List classes = getTodayClasses(
                              [snapshot.data!],
                              DateFormat('EEEE').format(DateTime
                                  .now())); 
                          if (classes.isNotEmpty) {
                            children = <Widget>[
                              ListView.builder(
                                  itemCount: classes.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    return Card(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: ListTile(
                                            title: Text(classes[index]
                                                    ["subject"] +
                                                classes[index]["courseNumber"]
                                                    .toString()),
                                            subtitle: Text(classes[index]
                                                        ["meetingTimes"][0]
                                                    ["buildingDescription"] +
                                                ' ' +
                                                classes[index]["meetingTimes"]
                                                    [0]["room"]),
                                            trailing: Text(
                                                meetingTime(classes[index]["meetingTimes"], 1))));
                                  })),
                            ];
                          } else {
                            children = <Widget>[
                              const Text.rich(TextSpan(
                                  text: '(*-ω-)',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300))),
                              const Text.rich(TextSpan(
                                  text: 'No classes today!',
                                  style: TextStyle(fontSize: 18))),
                            ];
                          }
                        } else if (snapshot.hasError) {
                          children = const <Widget>[
                            Icon(Icons.error_outline,
                                color: Colors.red, size: 30),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Error occured'),
                            ),
                          ];
                        } else {
                          children = const <Widget>[
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Loading schedule'),
                            ),
                          ];
                        }
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ));
                      }),
                ]),
          ),
        )
      ]),
    ));
  }
}
