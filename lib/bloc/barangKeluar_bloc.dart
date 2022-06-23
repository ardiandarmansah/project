import 'dart:convert';

import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/barangKeluar.dart';

class BarangKeluarBloc {
  static Future<List<BarangKeluar>> getBarangKeluars() async {
    String apiUrl = ApiUrl.listBarangKeluar;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBarangKeluar = (jsonObj as Map<String, dynamic>)['data'];
    List<BarangKeluar> barangKeluars = [];
    for (int i = 0; i < listBarangKeluar.length; i++) {
      barangKeluars.add(BarangKeluar.fromJson(listBarangKeluar[i]));
    }
    return barangKeluars;
  }

  static Future addBarangKeluar({BarangKeluar? barangKeluar}) async {
    String apiUrl = ApiUrl.createSupplier;

    var body = {
      "nama_barang": barangKeluar!.namaBarang,
      "tanggal_barang": barangKeluar.tanggalBarang,
      "user,": barangKeluar.user,
      "jumlah": barangKeluar.jumlah,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateBarangKeluar(
      {required BarangKeluar barangKeluar}) async {
    String apiUrl = ApiUrl.updateBarangKeluar(barangKeluar.id!);

    var body = {
      "nama_barang": barangKeluar.namaBarang,
      "tanggal_barang": barangKeluar.tanggalBarang,
      "user,": barangKeluar.user,
      "jumlah": barangKeluar.jumlah,
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteBarangKeluar({int? id}) async {
    String apiUrl = ApiUrl.deleteBarangKeluar(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
