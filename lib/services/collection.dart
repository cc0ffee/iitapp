import 'dart:convert';
import 'package:flutter/services.dart';

Future<List> readSchedule() async {
  String response = await rootBundle.loadString('assets/schoolSchedule.json');
  var data = await json.decode(response.toString());
  List dataList = data["data"]["registrations"];
  return dataList;
}

Future<List> readAssignments() async {
  String response = await rootBundle.loadString('assets/assignmentData.json');
  var data = await json.decode(response.toString());
  List dataList = data["results"];
  return dataList;
}

Future<List> readUrls() async {
  String response = await rootBundle.loadString('assets/urls.json');
  var data = await json.decode(response.toString());
  List dataList = data;
  return dataList;
}
