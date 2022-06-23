class Supplier {
  int? id;
  String? namaSupplier;
  String? alamatSupplier;
  String? notlpSupplier;

  Supplier(
      {this.id, this.namaSupplier, this.alamatSupplier, this.notlpSupplier});

  factory Supplier.fromJson(Map<String, dynamic> obj) {
    return Supplier(
        id: obj['id'],
        namaSupplier: obj['nama_supplier'],
        alamatSupplier: obj['alamat_supplier'],
        notlpSupplier: obj['notlp_supplier']);
  }
}
