import 'package:shared_preferences/shared_preferences.dart';

setToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', token);
  print("Token set");
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('accessToken');
  return stringValue;
}

checkToken() async {
  String value = await getToken() ?? null;
  return value;
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');
}
