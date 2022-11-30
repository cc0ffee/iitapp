import 'package:flutter/material.dart';
import 'package:myiit/services/collection.dart';
import 'package:myiit/services/format.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  Future<List> currentAssignments =
      Future.delayed(const Duration(seconds: 2), () => readAssignments());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTextStyle(
            style: Theme.of(context).textTheme.displaySmall!,
            textAlign: TextAlign.center,
            child: SingleChildScrollView(
                child: Column(children: [
              Card(
                  margin: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder<List>(
                        future: currentAssignments,
                        builder: (context, AsyncSnapshot<List> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          "Assignments",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    const SizedBox(height: 6),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: (snapshot.data!.length),
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: ((context, index) {
                                          return Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 10, 0, 10),
                                                      child: ListTile(
                                                        title: Text(snapshot
                                                                .data![index]
                                                            ["title"]),
                                                        subtitle: Text(formatClassName(
                                                            snapshot.data![
                                                                        index][
                                                                    "calendarNameLocalizable"]
                                                                ["rawValue"])),
                                                        trailing: Text(formatTime(
                                                                snapshot.data![
                                                                        index]
                                                                    ["endDate"],
                                                                0)
                                                            .toString()),
                                                      ))));
                                        }))
                                  ])
                            ];
                          } else if (snapshot.hasError) {
                            children = const <Widget>[
                              Icon(Icons.error_outline,
                                  color: Colors.red, size: 60),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Something went wrong.'),
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
                                child: Text('Getting assignments'),
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
