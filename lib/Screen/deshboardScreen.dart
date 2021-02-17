import 'dart:collection';

import 'package:drivably_app/Module/routing.dart';
import 'package:drivably_app/Screen/wapperClass.dart';
import 'package:drivably_app/Services/localStorage.dart';
import 'package:flutter/material.dart';

class DeshboardScreen extends StatefulWidget {
  DeshboardScreen({Key key}) : super(key: key);

  @override
  _DeshboardScreenState createState() => _DeshboardScreenState();
}

class _DeshboardScreenState extends State<DeshboardScreen> {
  MapView controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GJ 32 xx 2343"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [],
        leading: Icon(
          Icons.next_plan,
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi! John,",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Good Morning!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Current Driver is Richard Wiliams,",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 70),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF2B2B2B),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            onTap: (value) {
              print(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Home",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await removeToken();
          removeUntil(
            context,
            WapperClass(),
          );
        },
      ),
    );
  }
}
