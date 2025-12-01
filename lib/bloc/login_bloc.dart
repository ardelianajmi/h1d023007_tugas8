import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    var response = await Api().post(apiUrl, body, useToken: false);

    // response di sini adalah http.Response (kalau status 200/201)
    print('RAW LOGIN BODY: ${response.body}');

    var jsonObj = json.decode(response.body);
    print('DECODED LOGIN JSON: $jsonObj');

    return Login.fromJson(jsonObj);
  }
}
