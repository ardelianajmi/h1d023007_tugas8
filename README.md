# h1d023007_tugas8

Deskripsi Aplikasi

Aplikasi ini merupakan implementasi UI CRUD Produk sesuai Modul Pertemuan 10. Seluruh bagian aplikasi sudah menggunakan nama panggilan “Adel” pada setiap Action Bar, sehingga tampilan aplikasi menjadi lebih personal dan konsisten, diantaranya:

Halaman	Judul AppBar

Login	Login Adel

Registrasi	Registrasi Adel

List Produk	List Produk Adel

Tambah Produk	Tambah Produk Adel

Ubah Produk	Ubah Produk Adel

Detail Produk	Detail Produk Adel


Aplikasi dibangun menggunakan Flutter dan nantinya akan dihubungkan dengan REST API CodeIgniter 4 untuk proses autentikasi, manajemen produk, dan komunikasi database.

Struktur 

lib/

 ├── main.dart
 
 ├── model/
 
 │    ├── produk.dart
 
 │    ├── login.dart
 
 │    └── registrasi.dart
 
 └── ui/
 
      ├── login_page.dart
      
      ├── register_page.dart
      
      ├── produk_page.dart
      
      ├── produk_form.dart
      
      └── produk_detail.dart

Tampilan Aplikasi

🔐 Login	Login

📝 Registrasi	Registrasi

📋 List Produk	List

➕ Tambah Produk	Tambah

🔍 Detail Produk	Detail


1. Halaman Login — login_page.dart

<img width="1036" height="701" alt="image" src="https://github.com/user-attachments/assets/0882834b-d2c6-446c-be22-16d2bd44473f" />

Fungsi:

Input email & password

Validasi form

Navigasi ke halaman registrasi

Komponen	Fungsi
Email Field	Input email
Password Field	Input password
Tombol Login	Validasi & navigasi
Link Registrasi	Menuju halaman registrasi

2. Halaman Registrasi — registrasi_page.dart

<img width="1036" height="701" alt="image" src="https://github.com/user-attachments/assets/13dbde5b-84b7-4976-a74b-0d6ae94f73c7" />

Fungsi:

Mendaftarkan pengguna baru

Validasi email, password, dan konfirmasi password

3. List Produk — produk_page.dart

<img width="1036" height="701" alt="image" src="https://github.com/user-attachments/assets/a33db05f-9d82-4da7-8b45-32092cd316bd" />

Fungsi:

Menampilkan daftar produk berbasis Card

Fitur:

✔ List produk

✔ Drawer dengan tombol logout

✔ FAB tambah produk

✔ Klik card → menuju detail produk


4. Tambah / Edit Produk — produk_form.dart

<img width="1036" height="701" alt="image" src="https://github.com/user-attachments/assets/fe1b2157-0978-4fd1-8bc0-b31831957c2f" />

Halaman ini otomatis menyesuaikan mode:

Mode	Kondisi
Tambah Produk	widget.produk == null
Ubah Produk	widget.produk != null

5. Detail Produk — produk_detail.dart

<img width="1036" height="701" alt="image" src="https://github.com/user-attachments/assets/d382542f-079f-45d1-b7d7-996f128ef7c6" />

Fungsi:
Menampilkan informasi lengkap produk yang dipilih, meliputi:

Kode Produk

Nama Produk

Harga Produk

Tombol tersedia:

Tombol	Aksi
Edit	Membuka produk_form.dart
Hapus	

setelah mempelajari modul pertemuan 11 jd kita belajar login register dengan tautan lain pake database, postman, dan ada codeigniter

<img width="1366" height="728" alt="image" src="https://github.com/user-attachments/assets/6eb6aabd-3757-4dd0-bf0b-97d4419cc0a0" />

<img width="1366" height="728" alt="image" src="https://github.com/user-attachments/assets/4fcc1967-e0a9-4608-8ee3-0c386c84cd1e" />

<img width="1366" height="728" alt="image" src="https://github.com/user-attachments/assets/4dc23546-f9f2-4ce1-86d0-7391b18270bb" />

Frontend (Flutter)
– Yang dipakai user: tampilan form Login & Registrasi, halaman Produk, dll.

Backend (CodeIgniter 4 + Database MySQL)
– Yang mengolah data: simpan user baru, cek email & password, buat token login, ambil data produk, dll.
– Diakses melalui REST API (HTTP) dan bertukar data dalam format JSON.

Untuk memastikan API bekerja dengan benar, pengujian sering dilakukan menggunakan Postman sebelum dihubungkan ke Flutter.

Flutter (UI & Logic)

   |
   
   | HTTP Request (POST/GET) - body: form-data
   
   v
   
CodeIgniter 4 (REST API Controller)

   |
   
   | Query  
   
   v 
   
Database MySQL (tabel member, login, produk, dll)

   |
   
   | Hasil query
   
   v
   
CodeIgniter 4 (susun JSON response)

   |
   
   | JSON Response (code, status, data) 
   
   v
   
Flutter (Bloc & Model parsing JSON)


Alur Kerja REGISTRASI
1. User isi form Registrasi di Flutter

Di RegistrasiPage, user mengisi:

Nama

Email

Password

Konfirmasi password

Saat tombol Registrasi ditekan:

RegistrasiBloc.registrasi(
  nama: _namaTextboxController.text,
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
);

2. Flutter kirim request ke API CodeIgniter

RegistrasiBloc memanggil class Api:

String apiUrl = ApiUrl.registrasi; // http://localhost:8080/registrasi
var body = {"nama": nama, "email": email, "password": password};

final response = await Api().post(apiUrl, body, useToken: false);


Ini membuat HTTP POST ke:

URL: http://localhost:8080/registrasi

Body: nama, email, password

Format: form-data / x-www-form-urlencoded

3. CodeIgniter menerima & mengolah

Di RegistrasiController:

$data = [
    'nama'     => $this->request->getVar('nama'),
    'email'    => $this->request->getVar('email'),
    'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT),
];

$model = new MRegistrasi();
$model->save($data);

return $this->responseHasil(200, 'success', 'Registrasi Berhasil');


Yang dilakukan:

Ambil data dari request (getVar('nama'), dst).

Password di-hash dulu (bukan disimpan mentah).

Simpan ke Database lewat model MRegistrasi.

Mengembalikan JSON response seperti:

{
  "code": 200,
  "status": "success",
  "data": "Registrasi Berhasil"
}

4. Flutter menerima JSON & mem-parsing

RegistrasiBloc:

final jsonObj = json.decode(response.body);
return Registrasi.fromJson(jsonObj);


Model:

class Registrasi {
  int? code;
  String? status;
  String? data;

  Registrasi({this.code, this.status, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      code: json['code'] as int?,
      status: json['status'] as String?,
      data: json['data'] as String?,
    );
  }
}


Kalau tidak ada error (status code 200), di RegistrasiPage akan muncul SuccessDialog:

SuccessDialog(
  description: "Registrasi berhasil, silahkan login",
  okClick: () {
    Navigator.pop(context);
    Navigator.pop(context); // kembali ke halaman login
  },
)

🔑 Alur Kerja LOGIN
1. User isi form Login di Flutter

Di LoginPage, user mengisi:

Email

Password

Lalu tekan tombol Masuk, yang memanggil:

LoginBloc.login(
  email: _emailController.text,
  password: _passwordController.text,
);

2. Flutter kirim request ke API Login

LoginBloc:

String apiUrl = ApiUrl.login; // http://localhost:8080/login
var body = {"email": email, "password": password};

final response = await Api().post(apiUrl, body, useToken: false);
final jsonObj = json.decode(response.body);
return Login.fromJson(jsonObj);

3. CodeIgniter cek user & buat token

Di LoginController:

Ambil email & password dari request.

Cek apakah email ada di tabel member (via MMember).

Kalau ada, cek apakah password_verify() cocok.

Kalau password benar:

Generate string random sebagai auth_key (token).

Simpan ke tabel login (via MLogin).

Susun data untuk client:

$data = [
    'token' => $authKey,
    'user'  => [
        'id'    => $member['id'],
        'email' => $member['email'],
    ],
];

return $this->responseHasil(200, true, $data);


JSON yang dikirim kembali ke Flutter:

{
  "code": 200,
  "status": true,
  "data": {
    "token": "6JVY4Jf4DUyq5MYg2L...",
    "user": {
      "id": "3",
      "email": "tur@admin.com"
    }
  }
}

4. Flutter mem-parsing JSON & menyimpan token

Model Login:

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


Di LoginPage, setelah LoginBloc.login() sukses:

if (value.code == 200) {
  await UserInfo().setToken(value.token.toString());
  await UserInfo().setUserID(int.parse(value.userID.toString()));

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const ProdukPage()),
  );
}


Yang terjadi:

Token dan userID disimpan lokal (misal pakai SharedPreferences lewat helper UserInfo).

Token ini akan dipakai lagi untuk request lain (misalnya CRUD Produk) melalui header Authorization: Bearer <token>.

User diarahkan ke halaman ProdukPage → artinya login berhasil.

🧪 Peran POSTMAN dalam Alur Ini

Sebelum Flutter dihubungkan, API biasanya dites dulu pakai Postman:

Test endpoint Registrasi

Method: POST

URL: http://localhost:8080/registrasi

Body: nama, email, password

Cek apakah response JSON-nya sesuai yang diinginkan.

Test endpoint Login

Method: POST

URL: http://localhost:8080/login

Body: email, password

Cek apakah:

Error muncul kalau email/password salah.

JSON berisi code, status, data.token, dan data.user.

Dengan Postman, jika ada error di backend (route salah, validasi gagal, JSON tidak sesuai), bisa diperbaiki dulu sebelum dikonsumsi oleh Flutter.

Catatan :

Database

Menyimpan data user (member), password yang sudah di-hash, dan token login.

CodeIgniter (Backend / API)

Penghubung antara Flutter dan Database.
Menerima request, akses DB, lalu mengembalikan JSON.

JSON

Format data standar yang mudah dibaca oleh Flutter dan backend.
Contoh: code, status, data, token, user.

Flutter (Frontend)

Menampilkan form & UI, memanggil API via HTTP, mem-parsing JSON menjadi model Dart (Login, Registrasi), dan menyimpan token untuk request berikutnya.

Postman

Alat bantu untuk menguji API secara manual sebelum diintegrasikan ke aplikasi Flutter.


