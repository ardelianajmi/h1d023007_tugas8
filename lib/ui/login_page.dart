import 'package:flutter/material.dart';
import '/bloc/login_bloc.dart';
import '/helpers/user_info.dart';
import '/ui/produk_page.dart';
import '/ui/register_page.dart';
import '/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isLoading = true);

    // 🔁 Panggil API login via Bloc
    LoginBloc.login(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then(
          (value) async {
            if (value.code == 200) {
              // simpan token & user id
              await UserInfo().setToken(value.token.toString());
              await UserInfo().setUserID(int.parse(value.userID.toString()));

              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProdukPage()),
              );
            } else {
              if (!mounted) return;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ),
              );
            }
          },
          onError: (error) {
            print('ERROR LOGIN: $error');

            if (!mounted) return;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) =>
                  WarningDialog(description: "Login gagal: $error"),
            );
          },
        )
        .whenComplete(() {
          if (!mounted) return;
          setState(() => _isLoading = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR DENGAN NAMA PANGGILAN
      appBar: AppBar(
        title: const Text('Login Adel'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF80AB), Color(0xFFFFB3C6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // BODY
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4EC), Color(0xFFFDEBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo bulat
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF80AB), Color(0xFFFFB3C6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Selamat Datang di Toko Kita',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'Login dulu untuk kelola produk kamu ✨',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 20),

                Card(
                  elevation: 8,
                  shadowColor: Colors.pink.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _emailTextField(),
                          const SizedBox(height: 14),
                          _passwordTextField(),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Lupa password?',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          _buttonLogin(),
                          const SizedBox(height: 10),
                          _registerSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        if (!value.contains('@')) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password harus diisi';
        }
        if (value.length < 3) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onLogin,
        child: _isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Masuk',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Widget _registerSection() {
    return Column(
      children: [
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Belum punya akun?', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegistrasiPage()),
                );
              },
              child: const Text(
                'Daftar sekarang',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFF80AB),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
