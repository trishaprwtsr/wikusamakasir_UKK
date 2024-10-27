import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // Needed for handling file (image)
import 'package:image_picker/image_picker.dart';
import 'package:wikusamakasir_ukk/kelolamenu.dart';
import 'package:wikusamakasir_ukk/menu_model.dart';
import 'package:wikusamakasir_ukk/menu_service.dart';

class TambahMenuPage extends StatefulWidget {
  @override
  _TambahMenuPageState createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  final _formKey = GlobalKey<FormState>();
  final MenuService _menuService = MenuService();

  String name = '';
  String code = '';
  double basePrice = 0;
  double salePrice = 0;
  String category = 'Minuman'; // Default value for dropdown
  double weight = 0.0;
  String unit = '';
  String description = '';

  File? _imageFile;

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk menyimpan produk ke Firebase
  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MenuModel newMenu = MenuModel(
        id: '',
        name: name,
        code: code,
        basePrice: basePrice,
        salePrice: salePrice,
        category: category,
        weight: weight,
        unit: unit,
        description: description,
        imageUrl: '', // Image URL will be added after upload
      );
      await _menuService.addMenu(newMenu, _imageFile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7), // Warna latar belakang
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Tambah Produk',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Set font to bold
            fontSize: 18, // Font size for AppBar title
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageFile == null
                        ? const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)
                        : Image.file(_imageFile!, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Nama Produk', (value) => name = value),
              const SizedBox(height: 10),
              _buildTextField('Kode', (value) => code = value),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField('Harga dasar', (value) => basePrice = double.parse(value), isNumeric: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Harga jual', (value) => salePrice = double.parse(value), isNumeric: true)),
                ],
              ),
              const SizedBox(height: 10),
              // Dropdown for category
              _buildCategoryDropdown(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField('Berat', (value) => weight = double.parse(value), isNumeric: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Satuan', (value) => unit = value)),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField('Deskripsi', (value) => description = value),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                child: Text('Simpan Produk', style: GoogleFonts.poppins(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat TextField yang dapat digunakan ulang
  Widget _buildTextField(String label, Function(String) onSaved, {bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      onSaved: (value) => onSaved(value!),
      validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
    );
  }

  // Fungsi untuk membuat dropdown kategori
  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Kategori',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        fillColor: Colors.white,
        filled: true,
      ),
      value: category,
      items: [
        DropdownMenuItem(value: 'Minuman', child: Text('Minuman')),
        DropdownMenuItem(value: 'Snack', child: Text('Snack')),
      ],
      onChanged: (value) {
        setState(() {
          category = value!;
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
    );
  }
}
