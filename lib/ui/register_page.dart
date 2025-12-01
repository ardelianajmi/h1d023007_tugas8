import 'package:flutter/material.dart';
import '/bloc/registrasi_bloc.dart';
import '/widget/success_dialog.dart';
import '/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  void dispose() {
    _namaTextboxController.dispose();
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 16),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama harus diisi";
        }
        if (value.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        // validasi harus diisi
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }

        // validasi email
        const String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
            r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
            r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

        final regex = RegExp(pattern);
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password harus diisi";
        }
        if (value.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Konfirmasi Password harus diisi";
        }
        // jika inputan tidak sama dengan password
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Registrasi
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                final validate = _formKey.currentState!.validate();
                if (validate) {
                  _submit();
                }
              },
        child: _isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text("Registrasi"),
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then(
      (value) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Registrasi berhasil, silahkan login",
            okClick: () {
              Navigator.pop(context); // tutup dialog
              // balik ke halaman sebelumnya (misal Login)
            },
          ),
        );
      },
      onError: (error) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) =>
              WarningDialog(description: "Registrasi gagal: $error"),
        );
      },
    );
  }
}
