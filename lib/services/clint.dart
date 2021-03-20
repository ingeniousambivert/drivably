import 'package:dio/dio.dart';
import 'package:key_app/services/local_services.dart';

import 'package:key_app/utils/const.dart';

class ApiServices {
  Dio dio = new Dio();

  Future signInUser(email, password) async {
    try {
      print(email + password);
      Response response = await dio.post(
        "$baseUrl/driver/signin",
        data: {
          "username": "$email",
          "password": "$password",
        },
      );
      print(response.data['access_token']);
      setTokenAndId(response.data['access_token']);
      setOwnerEmail(email);

      return "PASS";
    } catch (e) {
      print(e);
    }
  }
}
