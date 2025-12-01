class Registrasi {
  int? code;
  String? status; // <-- ini harus String
  String? data;

  Registrasi({this.code, this.status, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      code: json['code'] as int?,
      status: json['status'] as String?, // <-- cocok dengan API
      data: json['data'] as String?,
    );
  }
}
