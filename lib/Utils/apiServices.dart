import 'package:dio/dio.dart';
import 'package:drivably_app/Constants/const.dart';
import 'package:drivably_app/Storage/localStorage.dart';


class ApiServices {
  Dio dio = new Dio();
  final baseUrl = 'http://192.168.43.180';
  Future postSignIdUser() async {
    print(setUserName + setSignInPassword);
    try {
      Response response = await dio.post(
        "$baseUrl/signin",
        data: {
          "username": "$setUserName",
          "password": "$setSignInPassword",
        },
      );
      setTokenAndId(response.data['access_token'], response.data['id']);
    } catch (e) {
      print(e);
    }
  }

  Future postSignUpUser(name, email, password, phone) async {
    print("Enter in function");

    try {
      print("Enter in try block");

      Response response = await dio.post(
        "http://192.168.16.138:8008/signup",
        data: {
          "name": "$name",
          "email": "$email",
          "password": "$password",
          "phone": "$phone",
        },
      );
      // setTokenAndId(response.data['access_token'], response.data['id']);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future setDriver(file) async {
    String id = "602f4df57652d71cf7006bc4";
    FormData formData = FormData.fromMap({
      "image": "$file",
    });
    print(formData.fields);
    Response response = await dio.post(
      "http://192.168.43.180/user/face/$id",
      data: formData,
    );
    print(response);
  }
}
