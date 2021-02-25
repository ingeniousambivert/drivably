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
  List<String> driversEmail;
  List<String> driver;

  DriverDataSec({this.driversEmail});

  DriverDataSec.fromJson(Map<String, dynamic> json) {
    driversEmail = json['drivers_email'].cast<String>();
    for (var doc in driversEmail) {}
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
