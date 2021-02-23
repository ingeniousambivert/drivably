import 'package:dio/dio.dart';

import 'package:key_app/utils/const.dart';

class ApiServices {
  Dio dio = new Dio();

  Future signInUser(email, password) async {
    try {
      Response response = await dio.post(
        "$baseUrl/driver/signin",
        data: {
          "username": email,
          "password": password,
        },
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
