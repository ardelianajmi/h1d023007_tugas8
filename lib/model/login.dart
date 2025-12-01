class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;
  
  Login({this.code, this.status, this.token, this.userID, this.userEmail});
  
  factory Login.fromJson(Map<String, dynamic> json) {
    if (json['code'] == 200) {
      return Login(
        code: json['code'],
        status: json['status'],
        token: json['data']['token'],
        userID: int.parse(json['data']['user']['id'].toString()),
        userEmail: json['data']['user']['email'],
      );
    } else {
      return Login(
        code: json['code'],
        status: json['status'],
      );
    }
  }
}