import 'package:dio/dio.dart';
import 'package:drivably_app/constants/consts.dart';
import 'package:drivably_app/utils/storage/localStorage.dart';

/* TODO: 
POST - car/ (with safe_user object) 
PUT - user/ (with car licennse plate number)
PUT - user/ (with facial data)
*/

class APIServices {
  Dio dio = new Dio();

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
        "$baseUrl/signup",
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

  // get ID as a parameter
  Future setDriver(file) async {
    String id = "602f4df57652d71cf7006bc4";
    FormData formData = FormData.fromMap({
      "image": "$file",
    });
    print(formData.fields);
    Response response = await dio.post(
      "$baseUrl/user/face/$id",
      data: formData,
    );
    print(response);
  }
}
