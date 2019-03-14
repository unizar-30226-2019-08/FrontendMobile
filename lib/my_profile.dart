import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';

class MyProfile extends StatefulWidget {

  MyProfile();

  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return ProfileNavbar();
  }
}