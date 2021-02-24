import 'package:drivably_app/services/api/client.dart';
import 'package:drivably_app/utils/classes/driver.dart';
import 'package:flutter/material.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({Key key}) : super(key: key);

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
        child: FutureBuilder<List<DriverData>>(
          future: _services.getDrivers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data[index];

                      return ListTile(
                        title: Text(doc.name),
                        subtitle: Text(doc.email),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add driver"),
        icon: Icon(Icons.add),
        onPressed: () {
          _services.getDrivers();
        },
      ),
    );
  }
}
