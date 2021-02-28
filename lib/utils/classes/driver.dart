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
