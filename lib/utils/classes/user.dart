class UserData {
  String name;
  String email;
  int phone;
  bool owner;
  Null facialData;
  Null cars;

  UserData(
      {this.name,
      this.email,
      this.phone,
      this.owner,
      this.facialData,
      this.cars});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    owner = json['owner'];
    facialData = json['facial_data'];
    cars = json['cars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['owner'] = this.owner;
    data['facial_data'] = this.facialData;
    data['cars'] = this.cars;
    return data;
  }
}
