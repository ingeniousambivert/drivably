import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/screens/camera/camera.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:drivably_app/utils/constants/consts.dart';
import 'package:flutter/material.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({Key key}) : super(key: key);

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  APIServices _services = APIServices();
  @override
  Widget build(BuildContext context) {
    APIServices _services = APIServices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Drivers List"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
<<<<<<< HEAD
        child: Container(
          child: Center(
            child: MaterialButton(
              color: Colors.blueGrey,
              onPressed: () {
                _services.getDrivers();
              },
              child: Text(
                "Get Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        // child: FutureBuilder<List<DriverDataSec>>(
        //   future: _services.getDrivers(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) print(snapshot.error);
=======
        child: FutureBuilder<List<DriverData>>(
          future: _services.getDrivers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
>>>>>>> parent of 50efe40 (update some changes)

        //     return snapshot.hasData
        //         ? ListView.builder(
        //             itemCount: snapshot.data.length,
        //             itemBuilder: (context, index) {
        //               var doc = snapshot.data[index];

<<<<<<< HEAD
        //               return Card(
        //                 color: Colors.white,
        //                 child: Column(children: [
        //                   ListTile(
        //                     tileColor: Colors.white,
        //                     title: Text(doc.driversEmail.toString()),
        //                   ),
        //                 ]),
        //               );
        //             },
        //           )
        //         : Center(child: CircularProgressIndicator());
        //   },
        // ),
=======
                      return Card(
                        color: Colors.white,
                        child: Column(children: [
                          ListTile(
                            tileColor: Colors.white,
                            title: Text(doc.name),
                            subtitle: Text(doc.email),
                          ),
                        ]),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
>>>>>>> parent of 50efe40 (update some changes)
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add driver"),
        icon: Icon(Icons.add),
        onPressed: () {
          buildShowBottomSheet(context);
        },
      ),
    );
  }

  PersistentBottomSheetController buildShowBottomSheet(BuildContext context) {
    String name, email, phone, password;
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Add New Driver",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter Driver's name";
                          }
                          return null;
                        },
                        decoration: textFormFieldStyle("Driver's Name"),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter Driver's email";
                          }
                          return null;
                        },
                        decoration: textFormFieldStyle("Driver's Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter Driver's phone number";
                          }
                          return null;
                        },
                        decoration: textFormFieldStyle("Driver's Phone Number"),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter Driver's password";
                          }
                          return null;
                        },
                        decoration: textFormFieldStyle("Driver's Password"),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        onPressed: () async {
                          await _services.signUpDriver(
                              name, email, password, phone);
                          pushToNext(context, CameraScreen());
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "Way to Face Reg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
