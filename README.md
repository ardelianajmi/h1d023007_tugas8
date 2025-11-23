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
      ├── registrasi_page.dart
      ├── produk_page.dart
      ├── produk_form.dart
      └── produk_detail.dart

Tampilan Aplikasi
Halaman	Tampilan
🔐 Login	Login
📝 Registrasi	Registrasi
📋 List Produk	List
➕ Tambah Produk	Tambah
🔍 Detail Produk	Detail

1. Halaman Login — login_page.dart

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

Fungsi:

Mendaftarkan pengguna baru

Validasi email, password, dan konfirmasi password

3. List Produk — produk_page.dart

Fungsi:

Menampilkan daftar produk berbasis Card

Fitur:
✔ List produk
✔ Drawer dengan tombol logout
✔ FAB tambah produk
✔ Klik card → menuju detail produk

4. Tambah / Edit Produk — produk_form.dart

Halaman ini otomatis menyesuaikan mode:

Mode	Kondisi
Tambah Produk	widget.produk == null
Ubah Produk	widget.produk != null

5. Detail Produk — produk_detail.dart

Fungsi:
Menampilkan informasi lengkap produk yang dipilih, meliputi:

Kode Produk

Nama Produk

Harga Produk

Tombol tersedia:

Tombol	Aksi
Edit	Membuka produk_form.dart
Hapus	

