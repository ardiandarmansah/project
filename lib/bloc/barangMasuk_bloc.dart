import 'dart:convert';

import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/barangMasuk.dart';

class BarangMasukBloc {
  static Future<List<BarangMasuk>> getBarangMasuks() async {
    String apiUrl = ApiUrl.listBarangMasuk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBarangMasuk = (jsonObj as Map<String, dynamic>)['data'];
    List<BarangMasuk> barangMasuks = [];
    for (int i = 0; i < listBarangMasuk.length; i++) {
      barangMasuks.add(BarangMasuk.fromJson(listBarangMasuk[i]));
    }
    return barangMasuks;
  }

  static Future addBarangMasuk({BarangMasuk? barangMasuk}) async {
    String apiUrl = ApiUrl.createSupplier;

    var body = {
      "nama_barang": barangMasuk!.namaBarang,
      "tanggal_barang": barangMasuk.tanggalBarang,
      "nama_supplier": barangMasuk.namaSupplier,
      "jumlah": barangMasuk.jumlah,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateBarangMasuk(
      {required BarangMasuk barangMasuk}) async {
    String apiUrl = ApiUrl.updateBarangMasuk(barangMasuk.id!);

    var body = {
      "nama_barang": barangMasuk.namaBarang,
      "tanggal_barang": barangMasuk.tanggalBarang,
      "nama_supplier": barangMasuk.namaSupplier,
      "jumlah": barangMasuk.jumlah,
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteBarangMasuk({int? id}) async {
    String apiUrl = ApiUrl.deleteBarangMasuk(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
