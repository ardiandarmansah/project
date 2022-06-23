import 'package:flutter/material.dart';
import 'package:tokokita/model/barangMasuk.dart';
import 'package:tokokita/ui/barangMasuk_form.dart';
import 'package:tokokita/bloc/barangMasuk_bloc.dart';

class BarangMasukDetail extends StatefulWidget {
  BarangMasuk? barangMasuk;

  BarangMasukDetail({Key? key, this.barangMasuk}) : super(key: key);

  @override
  _BarangMasukDetailState createState() => _BarangMasukDetailState();
}

class _BarangMasukDetailState extends State<BarangMasukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail BarangMasuk'),
        backgroundColor: Color.fromRGBO(68, 0, 163, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama Barang : ${widget.barangMasuk!.namaBarang}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Tanggal Barang : ${widget.barangMasuk!.tanggalBarang}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Nama Supplier : ${widget.barangMasuk!.namaSupplier}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "jumlah : ${widget.barangMasuk!.jumlah}",
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
                      builder: (context) => BarangMasukForm(
                            barangMasuk: widget.barangMasuk!,
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
                    builder: (context) => BarangMasukForm(
                          barangMasuk: widget.barangMasuk!,
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
