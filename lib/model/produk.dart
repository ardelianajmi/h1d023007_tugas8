class Produk {
  String? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;

  Produk({
    this.id,
    this.kodeProduk,
    this.namaProduk,
    this.hargaProduk,
  });

  // Parsing dari JSON (response API CodeIgniter)
  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id']?.toString(),
      kodeProduk: json['kode_produk'],
      namaProduk: json['nama_produk'],
      hargaProduk: _parseHarga(json['harga']),
    );
  }

  // Untuk kirim data ke API (create / update)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_produk': kodeProduk,
      'nama_produk': namaProduk,
      'harga': hargaProduk,
    };
  }

  // Helper supaya bisa handle harga int / String
  static int? _parseHarga(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
