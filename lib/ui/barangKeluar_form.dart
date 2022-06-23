import 'package:flutter/material.dart';
import 'package:tokokita/bloc/barangKeluar_bloc.dart';
import 'package:tokokita/model/barangKeluar.dart';
import 'package:tokokita/ui/barangKeluar_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class BarangKeluarForm extends StatefulWidget {
  BarangKeluar? barangKeluar;

  BarangKeluarForm({Key? key, this.barangKeluar}) : super(key: key);

  @override
  _BarangKeluarFormState createState() => _BarangKeluarFormState();
}

class _BarangKeluarFormState extends State<BarangKeluarForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH";
  String tombolSubmit = "SIMPAN";

  final _namaBarangTextboxController = TextEditingController();
  final _tanggalBarangTextboxController = TextEditingController();
  final _userTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.barangKeluar != null) {
      setState(() {
        judul = "EDIT Barang Keluar";
        tombolSubmit = "UBAH";
        _namaBarangTextboxController.text = widget.barangKeluar!.namaBarang!;
        _tanggalBarangTextboxController.text =
            widget.barangKeluar!.tanggalBarang!;
        _userTextboxController.text = widget.barangKeluar!.user!;
        _jumlahTextboxController.text = widget.barangKeluar!.jumlah!;
      });
    } else {
      judul = "TAMBAH";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Color.fromRGBO(68, 0, 163, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaBarangTextField(),
                _tanggalBarangTextField(),
                _userTextField(),
                _jumlahTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Produk
  Widget _namaBarangTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Barang"),
      keyboardType: TextInputType.text,
      controller: _namaBarangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Barang harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Produk
  Widget _tanggalBarangTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Barang"),
      keyboardType: TextInputType.text,
      controller: _tanggalBarangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Barang harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga Produk
  Widget _userTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "User"),
      keyboardType: TextInputType.text,
      controller: _userTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "User harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah Barang"),
      keyboardType: TextInputType.text,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah Barang harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.barangKeluar != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    BarangKeluar createBarangKeluar = BarangKeluar(id: null);
    createBarangKeluar.namaBarang = _namaBarangTextboxController.text;
    createBarangKeluar.tanggalBarang = _tanggalBarangTextboxController.text;
    createBarangKeluar.user = _userTextboxController.text;
    createBarangKeluar.jumlah = _jumlahTextboxController.text;
    BarangKeluarBloc.addBarangKeluar(barangKeluar: createBarangKeluar).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BarangKeluarPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    BarangKeluar updateBarangKeluar = BarangKeluar(id: null);
    updateBarangKeluar.namaBarang = _namaBarangTextboxController.text;
    updateBarangKeluar.tanggalBarang = _tanggalBarangTextboxController.text;
    updateBarangKeluar.user = _userTextboxController.text;
    updateBarangKeluar.jumlah = _jumlahTextboxController.text;
    BarangKeluarBloc.updateBarangKeluar(barangKeluar: updateBarangKeluar).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BarangKeluarPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
