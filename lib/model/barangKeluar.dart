class BarangKeluar {
  int? id;
  String? namaBarang;
  String? tanggalBarang;
  String? user;
  String? jumlah;

  BarangKeluar(
      {this.id, this.namaBarang, this.tanggalBarang, this.user, this.jumlah});

  factory BarangKeluar.fromJson(Map<String, dynamic> obj) {
    return BarangKeluar(
        id: obj['id'],
        namaBarang: obj['nama_barang'],
        tanggalBarang: obj['tanggal_barang'],
        user: obj['user'],
        jumlah: obj['jumlah']);
  }
}
