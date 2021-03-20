class CarData {
  String carLicense;
  String carName;
  String ownerEmail;

  CarData({this.carLicense, this.carName, this.ownerEmail});

  CarData.fromJson(Map<String, dynamic> json) {
    carLicense = json['car_license'];
    carName = json['car_name'];
    ownerEmail = json['owner_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_license'] = this.carLicense;
    data['car_name'] = this.carName;
    data['owner_email'] = this.ownerEmail;
    return data;
  }
}
