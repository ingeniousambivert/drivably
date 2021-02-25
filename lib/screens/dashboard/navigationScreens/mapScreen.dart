import 'package:flutter/material.dart';

import '../../../utils/storage/localStorage.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String licenseNumber;

  @override
  void initState() {
    super.initState();

    getCarNumber().then((value) {
      licenseNumber = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nexon",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      licenseNumber,
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
