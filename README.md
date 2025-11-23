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

