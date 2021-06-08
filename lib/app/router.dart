import 'package:flutter/material.dart';

import 'package:managedo_mobile_app/screens/EducationInfoScreen/EducationInfo_view.dart';
import 'package:managedo_mobile_app/screens/ExampleScreen/Example_view.dart';
import 'package:managedo_mobile_app/screens/ListStudentsScreen/ListStudentsScreen_view.dart';
import 'package:managedo_mobile_app/screens/SemesterDetailsScreen/SemesterDetails_view.dart';
import 'package:managedo_mobile_app/screens/SemesterListScreen/SemesterList_view.dart';
import 'package:managedo_mobile_app/screens/StudentPerformanceScreen/StudentPerformanceGraph_view.dart';
import 'package:managedo_mobile_app/screens/allScreen.dart';

const String educationRoute = '/education';
const String listStudentsRoute = '/listStudents';
const String listSemestersRoute = '/listSemesters';
const String performanceGraphRoute = '/performanceGraph';
const String semesterDetailsRoute = '/semesterDetails';
const String exampleRoute = '/example';
const String allScreenRoute = '/allScreen';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case educationRoute:
      return EducationInfo.route(studentId: settings.arguments);
    case exampleRoute:
      return ExampleView.route();
    case listStudentsRoute:
      return ListStudentsScreen.route();
    case listSemestersRoute:
      final args = settings.arguments;
      return SemesterListView.route(
          educationId: args.educationId,
          studentId: args.studentId);
    case performanceGraphRoute:
      return StudentPerformanceGraph.route(fkEducationId: settings.arguments);
    case semesterDetailsRoute:
      final SemesterDetailsArguments args = settings.arguments;
      return SemesterDetailsView.route(
          semesterId: args.semesterId,
          educationId: args.educationId,
          studentId: args.studentId);
    case allScreenRoute:
      return AllScreen.route();
  }
  return null;
}
