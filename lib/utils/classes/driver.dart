import 'package:drivably_app/services/api/client.dart';

class DriverData {
  final String id, name, email, phone, owner, facialData, cars, createdAt;

  DriverData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.owner,
    this.facialData,
    this.cars,
    this.createdAt,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return new DriverData(
      id: json['id'].toString(),
      name: json['name'].toString(),
      email: json['email'].toString(),
      phone: json['owner'].toString(),
      facialData: json['facial_data'].toString(),
      cars: json['cars'].toString(),
      createdAt: json['created_at'].toString(),
    );
  }
}

class DriverDataSec {
  APIServices _services = APIServices();
  List<String> driversEmail;
  List<String> driver;

  DriverDataSec({this.driversEmail});

  DriverDataSec.fromJson(Map<String, dynamic> json) {
    driversEmail = json['drivers_email'].cast<String>();
    for (var doc in driversEmail) {
      _services.printDrivers(doc);
    }
  }

  printDriver() {
    for (var doc in driversEmail) {
      print(doc);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drivers_email'] = this.driversEmail;
    return data;
  }
}

class UserProfile {
  String name;
  String email;
  int phone;
  bool owner;
  Null facialData;
  Null cars;
  String createdAt;

  UserProfile(
      {this.name,
      this.email,
      this.phone,
      this.owner,
      this.facialData,
      this.cars,
      this.createdAt});

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    owner = json['owner'];
    facialData = json['facial_data'];
    cars = json['cars'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['owner'] = this.owner;
    data['facial_data'] = this.facialData;
    data['cars'] = this.cars;
    data['created_at'] = this.createdAt;
    return data;
  }
}
