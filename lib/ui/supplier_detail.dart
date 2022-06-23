import 'package:flutter/material.dart';
import 'package:tokokita/model/supplier.dart';
import 'package:tokokita/ui/supplier_form.dart';
import 'package:tokokita/bloc/supplier_bloc.dart';

class SupplierDetail extends StatefulWidget {
  Supplier? supplier;

  SupplierDetail({Key? key, this.supplier}) : super(key: key);

  @override
  _SupplierDetailState createState() => _SupplierDetailState();
}

class _SupplierDetailState extends State<SupplierDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Supplier'),
        backgroundColor: Color.fromRGBO(68, 0, 163, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama : ${widget.supplier!.namaSupplier}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Alamat : ${widget.supplier!.alamatSupplier}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "No Telpon : ${widget.supplier!.notlpSupplier}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupplierForm(
                            supplier: widget.supplier!,
                          )));
            }),
        //Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SupplierForm(
                          supplier: widget.supplier!,
                        )));
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
