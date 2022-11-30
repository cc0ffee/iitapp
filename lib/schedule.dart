import 'package:flutter/material.dart';
import 'package:myiit/services/collection.dart';
import 'package:myiit/services/format.dart';

// import 'package:myiit/main.dart';
// import 'services/collection.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Future<List> currentSchedule =
      Future.delayed(const Duration(seconds: 2), () => readSchedule());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTextStyle(
            style: Theme.of(context).textTheme.displaySmall!,
            textAlign: TextAlign.center,
            child: SingleChildScrollView(
                child: Column(children: [
              Card(
                  margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder<List>(
                        future: currentSchedule,
                        builder: (context, AsyncSnapshot<List> snapshot) {
                          late List<Widget> children = [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Schedule",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                          ];
                          List days = [
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday'
                          ];
                          if (snapshot.hasData) {
                            for (int i = 0; i < days.length; i++) {
                              List classes =
                                  getTodayClasses([snapshot.data!], days[i]);
                              children.add(Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 12),
                                    Text(
                                      days[i],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 6),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: classes.length,
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
                                                              ["meetingTimes"][0][
                                                          "buildingDescription"] +
                                                      ' ' +
                                                      classes[index]
                                                              ["meetingTimes"]
                                                          [0]["room"]),
                                                  trailing: Text(meetingTime(classes[index]["meetingTimes"], 1))));
                                        }))
                                  ]));
                            }
                          } else if (snapshot.hasError) {
                            children = const <Widget>[
                              Icon(Icons.error_outline,
                                  color: Colors.red, size: 60),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting schedule'),
                              ),
                            ];
                          } else {
                            children = const <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator.adaptive(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting schedule'),
                              ),
                            ];
                          }
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ));
                        },
                      )))
            ]))));
  }
}
