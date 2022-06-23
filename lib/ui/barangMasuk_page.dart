import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/barangMasuk_bloc.dart';
import 'package:tokokita/model/barangMasuk.dart';
import 'package:tokokita/ui/login_page.dart';
import 'package:tokokita/ui/barangMasuk_detail.dart';
import 'package:tokokita/ui/barangMasuk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/supplier_page.dart';
import 'package:tokokita/ui/barangKeluar_page.dart';
import 'package:tokokita/ui/user_page.dart';

class BarangMasukPage extends StatefulWidget {
  const BarangMasukPage({Key? key}) : super(key: key);

  @override
  _BarangMasukPageState createState() => _BarangMasukPageState();
}

class _BarangMasukPageState extends State<BarangMasukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Barang Masuk'),
        backgroundColor: Color.fromRGBO(68, 0, 163, 1),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BarangMasukForm()));
                },
              ))
        ],
      ),
      body: FutureBuilder<List>(
        future: BarangMasukBloc.getBarangMasuks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBarangMasuk(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ]),
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: Color.fromRGBO(68, 0, 163, 1),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserPage(),
            ));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                ),
                SizedBox(height: 12),
                Text(
                  'Admin',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  'admin@gmail.com',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Data Produk'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ProdukPage(),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Supplier'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SupplierPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_exploration),
              title: const Text('Barang Masuk'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BarangMasukPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_thresholding),
              title: const Text('Barang Keluar'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BarangKeluarPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()))
                    });
              },
            ),
          ],
        ),
      );
}

class ListBarangMasuk extends StatelessWidget {
  final List? list;

  const ListBarangMasuk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemBarangMasuk(
            barangMasuk: list![i],
          );
        });
  }
}

class ItemBarangMasuk extends StatelessWidget {
  final BarangMasuk barangMasuk;

  const ItemBarangMasuk({Key? key, required this.barangMasuk})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarangMasukDetail(
                      barangMasuk: barangMasuk,
                    )));
      },
      child: Card(
        color: Color.fromARGB(255, 118, 20, 255),
        child: ListTile(
          title: Text(
            barangMasuk.namaBarang!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            barangMasuk.tanggalBarang!,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
