class BarangMasuk {
  int? id;
  String? namaBarang;
  String? tanggalBarang;
  String? namaSupplier;
  String? jumlah;

  BarangMasuk(
      {this.id,
      this.namaBarang,
      this.tanggalBarang,
      this.namaSupplier,
      this.jumlah});

  factory BarangMasuk.fromJson(Map<String, dynamic> obj) {
    return BarangMasuk(
        id: obj['id'],
        namaBarang: obj['nama_barang'],
        tanggalBarang: obj['tanggal_barang'],
        namaSupplier: obj['nama_supplier'],
        jumlah: obj['jumlah']);
  }
}
