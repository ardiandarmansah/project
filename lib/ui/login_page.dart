import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(98, 0, 238, 1),
        padding: EdgeInsets.all(20.20),
        child: ListView(
          children: <Widget>[
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _logo(),
                    const Padding(padding: EdgeInsets.all(10)),
                    _loginLabel(),
                    const Padding(padding: EdgeInsets.all(10)),
                    _emailTextField(),
                    _passwordTextField(),
                    const Padding(padding: EdgeInsets.all(5)),
                    _buttonLogin(),
                    const SizedBox(
                      height: 30,
                    ),
                    _menuRegistrasi(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    // ignore: prefer_const_constructors
    return Center(
      child: const CircleAvatar(
        radius: 120,
        backgroundImage: NetworkImage(
            'https://cdn.dribbble.com/users/1069761/screenshots/14019481/media/c5ca79afb1ad12b72b4805f794701366.png?compress=1&resize=400x300&vertical=top'),
      ),
    );
  }

  // ignore: unused_element
  Widget _loginLabel() {
    return Center(
      child: Text(
        "Login",
        style: GoogleFonts.josefinSans(
          // ignore: unnecessary_const
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 24, 0, 80),
            fontWeight: FontWeight.w900,
            fontSize: 34,
          ),
        ),
      ),
    );
  }

  //Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        //validasi harus diisi
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  //Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        //jika karakter yang dimasukkan kurang dari 6 karakter
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        });
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserID(int.parse(value.userID.toString()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProdukPage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
