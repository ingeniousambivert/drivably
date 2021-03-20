import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

enum TypeOfFeedback { haptic, sound, both }

class _SettingScreenState extends State<SettingScreen> {
  double _speed = 0, _volume = 0;
  List radioLableList = ["Haptic Feedback", "Sound Feedback", "Both"];
  TypeOfFeedback _type = TypeOfFeedback.haptic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Speed Cap Controller",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Slider(
                  min: 0,
                  max: 100,
                  value: _speed,
                  onChanged: (value) {
                    setState(() {
                      _speed = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    _speed.toInt().toString(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Volume Cap Controller",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Slider(
                  min: 0,
                  max: 20,
                  value: _volume,
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    _volume.toInt().toString(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Drowsiness Alert",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            ListTile(
              title: Text(radioLableList[0]),
              leading: Radio(
                value: TypeOfFeedback.haptic,
                groupValue: _type,
                onChanged: (TypeOfFeedback value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(radioLableList[1]),
              leading: Radio(
                value: TypeOfFeedback.sound,
                groupValue: _type,
                onChanged: (TypeOfFeedback value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(radioLableList[2]),
              leading: Radio(
                value: TypeOfFeedback.both,
                groupValue: _type,
                onChanged: (TypeOfFeedback value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
