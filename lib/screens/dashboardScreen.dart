import 'package:flutter/material.dart';
import 'package:key_app/services/local_services.dart';
import 'package:dio/dio.dart';
import 'package:key_app/utils/const.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Dio dio = Dio();
  String plateNumber = "xx00xx0000", carName = "";
  Future getData() async {
    String _token, _email;
    await getToken().then((value) {
      _token = value;
    });

    await getEmail().then((value) {
      _email = value;
    });

    String replaceEmail = _email.replaceAll('@', '%40');
    Response response = await dio.get(
      "$baseUrl/user/car/?email=$replaceEmail",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );
    print(response.data['data'][0]);
    setState(() {
      plateNumber = response.data['data'][0]['car_license'];
      carName = response.data['data'][0]['car_name'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "DRIVABLY KEY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              Text(
                "Access your car",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      plateNumber,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      carName,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // FlatButton(
              //   color: Colors.white,
              //   onPressed: (){
              //     getCurrentLocation();
              //   },
              //    child: Text("Click")
              //    ),
            ],
          ),
        ),
      ),
    );
  }
}
