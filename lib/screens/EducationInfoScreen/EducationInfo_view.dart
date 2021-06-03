import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import './components/body.dart';

import '../view.dart';
import 'EducationInfo_viewmodel.dart';

class EducationInfo extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => EducationInfo());

  @override
  _EducationInfoState createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  int currentPage = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu_book_rounded),
            title: Text('Education Information'),
            centerTitle: true,
          ),
          body: View<EducationInfoViewmodel>(
            initViewmodel: (viewmodel) =>
                viewmodel.getEducationListBasedOnStudentId(1),
            builder: (context, viewmodel, _) {
              return Body(state: this, viewmodel: viewmodel);
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {},
          ),
          bottomNavigationBar: FancyBottomNavigation(
            circleColor: Colors.green,
            initialSelection: currentPage,
            tabs: [
              TabData(
                iconData: Icons.person,
                title: 'Profile',
              ),
              TabData(
                iconData: Icons.home,
                title: 'Home',
              ),
              TabData(
                iconData: Icons.menu_book_rounded,
                title: 'Education',
              ),
              TabData(
                iconData: Icons.auto_graph,
                title: 'Performance',
              ),
            ],
            onTabChangedListener: (int position) {
              setState(() {
                currentPage = position;
              });
            },
          ),
        ),
      ),
    );
  }
}
