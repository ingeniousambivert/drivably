import 'package:drivably_app/screens/dashboard/navigationScreens/addDriver.dart';
import 'package:drivably_app/screens/dashboard/navigationScreens/mapScreen.dart';
import 'package:drivably_app/screens/dashboard/navigationScreens/notificationScreen.dart';

import 'package:drivably_app/screens/dashboard/navigationScreens/settingScreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List _selectedWidged = [
    MapScreen(),
    DriverScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedWidged.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Drivers List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: "notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
