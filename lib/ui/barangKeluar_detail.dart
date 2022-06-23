import 'package:flutter/material.dart';
import 'package:tokokita/model/barangKeluar.dart';
import 'package:tokokita/ui/barangKeluar_form.dart';
import 'package:tokokita/bloc/barangKeluar_bloc.dart';

class BarangKeluarDetail extends StatefulWidget {
  BarangKeluar? barangKeluar;

  BarangKeluarDetail({Key? key, this.barangKeluar}) : super(key: key);

  @override
  _BarangKeluarDetailState createState() => _BarangKeluarDetailState();
}

class _BarangKeluarDetailState extends State<BarangKeluarDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail BarangKeluar'),
        backgroundColor: Color.fromRGBO(68, 0, 163, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama Barang : ${widget.barangKeluar!.namaBarang}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Tanggal Barang : ${widget.barangKeluar!.tanggalBarang}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "User : ${widget.barangKeluar!.user}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Jumlah : ${widget.barangKeluar!.jumlah}",
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
                      builder: (context) => BarangKeluarForm(
                            barangKeluar: widget.barangKeluar!,
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
                    builder: (context) => BarangKeluarForm(
                          barangKeluar: widget.barangKeluar!,
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
