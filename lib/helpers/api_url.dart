class ApiUrl {
  static const String baseUrl = 'http://192.168.43.69/toko-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';
  static const String listSupplier = baseUrl + '/supplier';
  static const String createSupplier = baseUrl + '/supplier';
  static const String listBarangMasuk = baseUrl + '/barangMasuk';
  static const String createBarangMasuk = baseUrl + '/barangMasuk';
  static const String listBarangKeluar = baseUrl + '/barangKeluar';
  static const String createBarangKeluar = baseUrl + '/barangKeluar';

  static String updateProduk(int id) {
    return baseUrl + '/produk/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String updateSupplier(int id) {
    return baseUrl + '/supplier/' + id.toString() + '/update';
  }

  static String showSupplier(int id) {
    return baseUrl + '/supplier/' + id.toString();
  }

  static String deleteSupplier(int id) {
    return baseUrl + '/supplier/' + id.toString();
  }

  static String updateBarangMasuk(int id) {
    return baseUrl + '/barangMasuk/' + id.toString() + '/update';
  }

  static String showBarangMasuk(int id) {
    return baseUrl + '/barangMasuk/' + id.toString();
  }

  static String deleteBarangMasuk(int id) {
    return baseUrl + '/barangMasuk/' + id.toString();
  }

  static String updateBarangKeluar(int id) {
    return baseUrl + '/barangKeluar/' + id.toString() + '/update';
  }

  static String showBarangKeluar(int id) {
    return baseUrl + '/barangKeluar/' + id.toString();
  }

  static String deleteBarangKeluar(int id) {
    return baseUrl + '/barangKeluar/' + id.toString();
  }
}
