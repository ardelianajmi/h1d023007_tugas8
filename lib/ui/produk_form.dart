import 'package:flutter/material.dart';
import '/model/produk.dart';
import '/ui/produk_page.dart';
import '/bloc/produk_bloc.dart';
import '/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late String judul;
  late String tombolSubmit;

  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupForm();
  }

  void _setupForm() {
    if (widget.produk != null) {
      judul = 'Ubah Produk Adel';
      tombolSubmit = 'Ubah';
      _kodeProdukController.text = widget.produk!.kodeProduk ?? '';
      _namaProdukController.text = widget.produk!.namaProduk ?? '';
      _hargaProdukController.text =
          widget.produk!.hargaProduk?.toString() ?? '';
    } else {
      judul = 'Tambah Produk Adel';
      tombolSubmit = 'Simpan';
    }
  }

  @override
  void dispose() {
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaProdukController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isLoading = true);

    final bool isUpdate = widget.produk != null;

    // siapkan objek produk
    final Produk dataProduk = isUpdate
        ? Produk(id: widget.produk!.id)
        : Produk(id: null);

    dataProduk.kodeProduk = _kodeProdukController.text;
    dataProduk.namaProduk = _namaProdukController.text;
    dataProduk.hargaProduk = int.parse(_hargaProdukController.text);

    // panggil Bloc sesuai mode (tambah / ubah)
    final Future future = isUpdate
        ? ProdukBloc.updateProduk(produk: dataProduk)
        : ProdukBloc.addProduk(produk: dataProduk);

    future
        .then(
          (value) {
            if (!mounted) return;

            // opsional: tampilkan snackbar sukses
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isUpdate
                      ? 'Produk berhasil diubah ✅'
                      : 'Produk baru berhasil disimpan ✅',
                ),
              ),
            );

            // balik ke halaman list produk
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const ProdukPage()),
              (route) => false,
            );
          },
          onError: (error) {
            if (!mounted) return;
            showDialog(
              context: context,
              builder: (_) => WarningDialog(
                description: isUpdate
                    ? "Permintaan ubah data gagal, silahkan coba lagi"
                    : "Simpan gagal, silahkan coba lagi",
              ),
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
      appBar: AppBar(
        title: Text(judul),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5F8), Color(0xFFFDEBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shadowColor: Colors.pink.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _kodeProdukTextField(),
                    const SizedBox(height: 12),
                    _namaProdukTextField(),
                    const SizedBox(height: 12),
                    _hargaProdukTextField(),
                    const SizedBox(height: 20),
                    _buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      controller: _kodeProdukController,
      decoration: const InputDecoration(
        labelText: 'Kode Produk',
        prefixIcon: Icon(Icons.qr_code_2),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kode produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      controller: _namaProdukController,
      decoration: const InputDecoration(
        labelText: 'Nama Produk',
        prefixIcon: Icon(Icons.shopping_bag_outlined),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama produk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      controller: _hargaProdukController,
      decoration: const InputDecoration(
        labelText: 'Harga',
        prefixIcon: Icon(Icons.payments_outlined),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harga harus diisi';
        }
        if (int.tryParse(value) == null) {
          return 'Harga harus berupa angka';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _onSubmit,
        icon: _isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.save_outlined),
        label: Text(
          tombolSubmit,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
