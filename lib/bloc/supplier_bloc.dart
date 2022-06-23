import 'dart:convert';

import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/supplier.dart';

class SupplierBloc {
  static Future<List<Supplier>> getSuppliers() async {
    String apiUrl = ApiUrl.listSupplier;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listSupplier = (jsonObj as Map<String, dynamic>)['data'];
    List<Supplier> suppliers = [];
    for (int i = 0; i < listSupplier.length; i++) {
      suppliers.add(Supplier.fromJson(listSupplier[i]));
    }
    return suppliers;
  }

  static Future addSupplier({Supplier? supplier}) async {
    String apiUrl = ApiUrl.createSupplier;

    var body = {
      "nama_supplier": supplier!.namaSupplier,
      "alamat_supplier": supplier.alamatSupplier,
      "notlp_supplier": supplier.notlpSupplier
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateSupplier({required Supplier supplier}) async {
    String apiUrl = ApiUrl.updateSupplier(supplier.id!);

    var body = {
      "nama_supplier": supplier.namaSupplier,
      "alamat_supplier": supplier.alamatSupplier,
      "notlp_supplier": supplier.notlpSupplier
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteSupplier({int? id}) async {
    String apiUrl = ApiUrl.deleteSupplier(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
