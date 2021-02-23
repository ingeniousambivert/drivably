class UserData {
  String id;
  String name;
  String email;
  int phone;
  bool owner;
  String facialData;
  Null cars;
  String createdAt;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.owner,
      this.facialData,
      this.cars,
      this.createdAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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
