import 'package:flutter/material.dart';
import 'package:managedo_mobile_app/screens/SemesterDetailsScreen/SemesterDetails_viewmodel.dart';
import 'package:managedo_mobile_app/screens/SemesterDetailsScreen/components/custom_course_list_tile.dart';
import 'package:managedo_mobile_app/screens/SemesterDetailsScreen/components/edit_course.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import './semester_details.dart';
import '../SemesterDetails_view.dart';

class Body extends StatelessWidget {
  final SemesterDetailsState _state;
  final SemesterDetailsViewmodel _viewmodel;

  Body({@required state, @required viewmodel})
      : _state = state,
        _viewmodel = viewmodel;

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black12,
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.white,
                  Colors.green,
                  Colors.white,
                  Colors.green,
                ],
              ),
            ),
            child: Card(
              color: Color.fromRGBO(0, 0, 0, 0),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: IconButton(
                            iconSize: 25,
                            icon: Icon(Icons.delete_forever_outlined),
                            onPressed: () => _showAlert(
                                context, _viewmodel.courses[index].id),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomCourseListTile(
                    label: 'Course Code',
                    details: _viewmodel.courses[index].courseCode.toUpperCase(),
                    onPressed: () async => await EditCourse.editCourseCode(
                      context: context,
                      currentValue: _viewmodel.courses[index].courseCode,
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].courseCode = value;
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                  CustomCourseListTile(
                    label: 'Course Name',
                    details: _viewmodel.courses[index].courseName,
                    onPressed: () async => await EditCourse.editCourseName(
                      context: context,
                      currentValue: _viewmodel.courses[index].courseName,
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].courseName = value;
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                  CustomCourseListTile(
                    label: 'Section',
                    details:
                        (_viewmodel.courses[index].section > 9 ? '' : '0') +
                            _viewmodel.courses[index].section.toString(),
                    onPressed: () async => await EditCourse.editSection(
                      context: context,
                      currentValue:
                          _viewmodel.courses[index].section.toString(),
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].section = int.parse(value);
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                  CustomCourseListTile(
                    label: 'Credit',
                    details: _viewmodel.courses[index].credit.toString(),
                    onPressed: () async => await EditCourse.editCredit(
                      context: context,
                      currentValue: _viewmodel.courses[index].credit.toString(),
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].credit = int.parse(value);
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                  CustomCourseListTile(
                    label: 'Targeted Grade',
                    details:
                        _viewmodel.courses[index].targetedGrade.toUpperCase(),
                    onPressed: () async => await EditCourse.editTargetedGrade(
                      context: context,
                      currentValue: _viewmodel.courses[index].targetedGrade,
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].targetedGrade = value;
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                  CustomCourseListTile(
                    label: 'Achieved Grade',
                    details:
                        _viewmodel.courses[index].achievedGrade.toUpperCase(),
                    onPressed: () async => await EditCourse.editAchievedGrade(
                      context: context,
                      currentValue: _viewmodel.courses[index].achievedGrade,
                    ).then(
                      (value) {
                        if (value != null) {
                          _viewmodel.courses[index].achievedGrade = value;
                          _state.updateSelectedCourse(
                              course: _viewmodel.courses[index]);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showAlert(BuildContext context, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Selected Course Information?'),
          content: Text("Are You Sure Want To Proceed?"),
          actions: <Widget>[
            TextButton(
              child: Text("YES"),
              onPressed: () {
                Navigator.of(context).pop();
                _state.deletedSelectedCourse(courseId: courseId);
              },
            ),
            TextButton(
              child: Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SemesterDetails(
              state: _state,
              viewmodel: _viewmodel,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              'List of Courses',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: _viewmodel.courses != null && _viewmodel.courses.length > 0
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.36,
                    child: ScrollSnapList(
                      onItemFocus: (index) => {},
                      itemSize: 10,
                      itemBuilder: _buildListItem,
                      itemCount: _viewmodel.courses.length,
                      reverse: true,
                      focusOnItemTap: true,
                    ),
                  )
                : Center(
                    child: Container(
                      child: Text('No Course Available'),
                    ),
                  ),
          ),
          Container(
            height: 80,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                Text(
                  ' Semester Details',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
