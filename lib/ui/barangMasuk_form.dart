import 'package:flutter/material.dart';
import 'package:tokokita/bloc/barangMasuk_bloc.dart';
import 'package:tokokita/model/barangMasuk.dart';
import 'package:tokokita/ui/barangMasuk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class BarangMasukForm extends StatefulWidget {
  BarangMasuk? barangMasuk;

  BarangMasukForm({Key? key, this.barangMasuk}) : super(key: key);

  @override
  _BarangMasukFormState createState() => _BarangMasukFormState();
}

class _BarangMasukFormState extends State<BarangMasukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH";
  String tombolSubmit = "SIMPAN";

  final _namaBarangTextboxController = TextEditingController();
  final _tanggalBarangTextboxController = TextEditingController();
  final _namaSupplierTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.barangMasuk != null) {
      setState(() {
        judul = "EDIT Barang Masuk";
        tombolSubmit = "UBAH";
        _namaBarangTextboxController.text = widget.barangMasuk!.namaBarang!;
        _tanggalBarangTextboxController.text =
            widget.barangMasuk!.tanggalBarang!;
        _namaSupplierTextboxController.text = widget.barangMasuk!.namaSupplier!;
        _jumlahTextboxController.text = widget.barangMasuk!.jumlah!;
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
                _namaSupplierTextField(),
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
  Widget _namaSupplierTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Supplier"),
      keyboardType: TextInputType.number,
      controller: _namaSupplierTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Supplier harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "jumlah Barang"),
      keyboardType: TextInputType.number,
      controller: _namaSupplierTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "jumlah Barang harus diisi";
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
              if (widget.barangMasuk != null) {
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
    BarangMasuk createBarangMasuk = BarangMasuk(id: null);
    createBarangMasuk.namaBarang = _namaBarangTextboxController.text;
    createBarangMasuk.tanggalBarang = _tanggalBarangTextboxController.text;
    createBarangMasuk.namaSupplier = _namaSupplierTextboxController.text;
    createBarangMasuk.jumlah = _jumlahTextboxController.text;
    BarangMasukBloc.addBarangMasuk(barangMasuk: createBarangMasuk).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BarangMasukPage()));
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
    BarangMasuk updateBarangMasuk = BarangMasuk(id: null);
    updateBarangMasuk.namaBarang = _namaBarangTextboxController.text;
    updateBarangMasuk.tanggalBarang = _tanggalBarangTextboxController.text;
    updateBarangMasuk.namaSupplier = _namaSupplierTextboxController.text;
    updateBarangMasuk.jumlah = _jumlahTextboxController.text;
    BarangMasukBloc.updateBarangMasuk(barangMasuk: updateBarangMasuk).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BarangMasukPage()));
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
