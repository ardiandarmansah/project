import 'package:flutter/material.dart';
import 'package:tokokita/bloc/supplier_bloc.dart';
import 'package:tokokita/model/supplier.dart';
import 'package:tokokita/ui/supplier_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class SupplierForm extends StatefulWidget {
  Supplier? supplier;

  SupplierForm({Key? key, this.supplier}) : super(key: key);

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH SUPPLIER";
  String tombolSubmit = "SIMPAN";

  final _namaSupplierTextboxController = TextEditingController();
  final _alamatSupplierTextboxController = TextEditingController();
  final _notlpSupplierTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.supplier != null) {
      setState(() {
        judul = "UBAH SUPPLIER";
        tombolSubmit = "UBAH";
        _namaSupplierTextboxController.text = widget.supplier!.namaSupplier!;
        _alamatSupplierTextboxController.text =
            widget.supplier!.alamatSupplier!;
        _notlpSupplierTextboxController.text = widget.supplier!.notlpSupplier!;
      });
    } else {
      judul = "TAMBAH SUPPLIER";
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
                _namaSupplierTextField(),
                _alamatSupplierTextField(),
                _notlpSupplierTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Produk
  Widget _namaSupplierTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Supplier"),
      keyboardType: TextInputType.text,
      controller: _namaSupplierTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Supplier harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Produk
  Widget _alamatSupplierTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Alamat Supplier"),
      keyboardType: TextInputType.text,
      controller: _alamatSupplierTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Alamat Supplier harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga Produk
  Widget _notlpSupplierTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "nomer telpon"),
      keyboardType: TextInputType.number,
      controller: _notlpSupplierTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "no telpon harus diisi";
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
              if (widget.supplier != null) {
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
    Supplier createSupplier = Supplier(id: null);
    createSupplier.namaSupplier = _namaSupplierTextboxController.text;
    createSupplier.alamatSupplier = _alamatSupplierTextboxController.text;
    createSupplier.notlpSupplier = _notlpSupplierTextboxController.text;
    SupplierBloc.addSupplier(supplier: createSupplier).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SupplierPage()));
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
    Supplier updateSupplier = Supplier(id: null);
    updateSupplier.id = widget.supplier!.id;
    updateSupplier.namaSupplier = _namaSupplierTextboxController.text;
    updateSupplier.alamatSupplier = _alamatSupplierTextboxController.text;
    updateSupplier.notlpSupplier = _notlpSupplierTextboxController.text;
    SupplierBloc.updateSupplier(supplier: updateSupplier).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SupplierPage()));
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
