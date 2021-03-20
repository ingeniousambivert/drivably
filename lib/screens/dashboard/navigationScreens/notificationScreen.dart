import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notifications"),
            backgroundColor: Colors.black,
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Drowsiness"),
                Tab(text: "Alcohol"),
                Tab(text: "Casualty"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  notificationCard(
                      "Drowsiness Alert",
                      "Location: 23.03° N, 72.56° E",
                      "the driver Abhishek Driver 1 has been detected drowsy at time 11:30 in car nexon.")
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  notificationCard(
                      "Alcohol Alert",
                      "Location: 23.03° N, 72.56° E",
                      "the driver Abhishek Driver 1 has been Has been found intoxicated."),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  notificationCard(
                      "Casualty Alert",
                      "Location: 23.03° N, 72.56° E",
                      "the driver Abhishek Driver 1 has been Has been in a casualty"),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Padding notificationCard(title, latlong, subtitle) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xff4875E5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.notification_important,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      latlong,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
