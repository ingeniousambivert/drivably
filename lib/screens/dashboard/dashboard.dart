import 'package:drivably_app/screens/camera/camera.dart';
import 'package:drivably_app/screens/dashboard/mapScreen.dart';
import 'package:drivably_app/screens/dashboard/settingScreen.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:drivably_app/utils/classes/user.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List _selectedWidged = [
    MapScreeen(),
    CameraScreen(),
    SettingScreen(),
  ];

  int _selectedIndex = 0;
  APIServices _services = APIServices();
  UserData _user = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedWidged.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _services.getUserData();
          print(_user.toJson());
        },
        child: Icon(Icons.get_app),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Driver",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
