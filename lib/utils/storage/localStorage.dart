import 'package:shared_preferences/shared_preferences.dart';

setTokenAndId(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', token);
  print("Token set");
}

setCarNumber(number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('licenseNumber', number);
  print("Number set");
}

setOwnerEmail(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  print("owner's email set");
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('accessToken');
  return stringValue;
}

Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('email');
  return stringValue;
}

Future<String> getCarNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('licenseNumber');
  return stringValue;
}

checkToken() async {
  String value = await getToken() ?? null;
  return value;
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');
  prefs.remove('userId');
}
