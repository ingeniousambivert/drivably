import 'package:flutter/material.dart';

class NotifactionScreen extends StatelessWidget {
  const NotifactionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifaction"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: [
            notifactionCard("Danger Notifaction Title", "Denger"),
            notifactionCard("Aleart Notifaction Title", "Aleart"),
          ],
        ),
      ),
    );
  }
}

Padding notifactionCard(notifactionTitle, code) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Card(
      color: code == "Denger" ? Colors.redAccent : Colors.orange,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.notifications_active,
              color: code == "Denger" ? Colors.white : Colors.black,
            ),
            title: Text(
              '$notifactionTitle',
              style: TextStyle(
                  color: code == "Denger" ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Secondary Text',
              style: TextStyle(
                  color: code == "Denger" ? Colors.white : Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(
                  color: code == "Denger" ? Colors.white : Colors.black),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: code == "Denger" ? Colors.white : Colors.black,
                onPressed: () {
                  // Perform some action
                },
                child: const Text('Get Location'),
              ),
              FlatButton(
                textColor: code == "Denger" ? Colors.white : Colors.black,
                onPressed: () {
                  // Perform some action
                },
                child: const Text('Call Driver'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
