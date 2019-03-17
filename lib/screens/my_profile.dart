import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';

class MyProfile extends StatefulWidget {

  MyProfile();

  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ProfileNavbar(preferredSize: Size.fromHeight(height/3.3)),
        body: TabBarView(
          children: [
            Scaffold(),
            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}