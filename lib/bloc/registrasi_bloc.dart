import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};

    var response = await Api().post(apiUrl, body, useToken: false);

    print('RAW REGISTRASI BODY: ${response.body}');

    var jsonObj = json.decode(response.body);
    print('DECODED REGISTRASI JSON: $jsonObj');

    return Registrasi.fromJson(jsonObj);
  }
}
