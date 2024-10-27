import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'menu_model.dart'; // Import model kamu
import 'menu_service.dart'; // Import service kamu

class EditMenuPage extends StatefulWidget {
  final MenuModel menu;

  const EditMenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  _EditMenuPageState createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _basePriceController;
  late TextEditingController _salePriceController;
  late TextEditingController _categoryController;
  late TextEditingController _weightController;
  late TextEditingController _unitController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai dari menu yang sedang diedit
    _nameController = TextEditingController(text: widget.menu.name);
    _codeController = TextEditingController(text: widget.menu.code);
    _basePriceController = TextEditingController(text: widget.menu.basePrice.toString());
    _salePriceController = TextEditingController(text: widget.menu.salePrice.toString());
    _categoryController = TextEditingController(text: widget.menu.category);
    _weightController = TextEditingController(text: widget.menu.weight.toString());
    _unitController = TextEditingController(text: widget.menu.unit);
    _descriptionController = TextEditingController(text: widget.menu.description);
  }

  @override
  void dispose() {
    // Bersihkan controller saat halaman dihapus
    _nameController.dispose();
    _codeController.dispose();
    _basePriceController.dispose();
    _salePriceController.dispose();
    _categoryController.dispose();
    _weightController.dispose();
    _unitController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateMenu() async {
    if (_formKey.currentState!.validate()) {
      // Mengupdate menu
      MenuModel updatedMenu = MenuModel(
        id: widget.menu.id, // Menggunakan ID yang sama
        name: _nameController.text,
        code: _codeController.text,
        basePrice: double.tryParse(_basePriceController.text) ?? 0.0,
        salePrice: double.tryParse(_salePriceController.text) ?? 0.0,
        category: _categoryController.text,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        unit: _unitController.text,
        description: _descriptionController.text,
        imageUrl: widget.menu.imageUrl, // Tetap menggunakan URL gambar yang sama
      );

      try {
        MenuService menuService = MenuService();
        await menuService.updateMenu(updatedMenu);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Menu berhasil diperbarui!')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memperbarui menu: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7), // Warna latar belakang
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE7), // Warna AppBar
        title: Text(
          'Edit Menu',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // Tindakan delete di sini
              await _deleteMenu();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Menggunakan GoogleFonts untuk gaya teks
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16), // Spasi antar field
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Kode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Kode tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _basePriceController,
                decoration: InputDecoration(
                  labelText: 'Harga Dasar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Harga Dasar tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _salePriceController,
                decoration: InputDecoration(
                  labelText: 'Harga Jual',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Harga Jual tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Berat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Berat tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(
                  labelText: 'Satuan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Satuan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateMenu,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.brown, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteMenu() async {
    try {
      MenuService menuService = MenuService();
      await menuService.deleteMenu(widget.menu.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Menu berhasil dihapus!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus menu: $e')));
    }
  }
}
