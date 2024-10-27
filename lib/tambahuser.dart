import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wikusamakasir_ukk/kelolauser.dart';

class TambahUserPage extends StatefulWidget {
  @override
  _TambahUserPageState createState() => _TambahUserPageState();
}

class _TambahUserPageState extends State<TambahUserPage> {
  String _selectedRole = 'Kasir';
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _name = '';
  String _email = '';
  String _password = '';
  File? _imageFile; // Untuk menyimpan file gambar
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Tambah User',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              _buildTextField('Nama Lengkap', (value) => _name = value),
              const SizedBox(height: 10),
              _buildTextField('Email', (value) => _email = value),
              const SizedBox(height: 10),
              _buildTextField('Kata Sandi', (value) => _password = value, isRequired: true, obscureText: true),
              const SizedBox(height: 20),
              _buildRoleDropdown(),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    backgroundColor: Colors.brown,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String? imageUrl;
                      if (_imageFile != null) {
                        imageUrl = await _uploadImage(_imageFile!);
                      }

                      await _firestore.collection('users').add({
                        'name': _name,
                        'email': _email,
                        'password': _password,
                        'role': _selectedRole,
                        'status': 'Aktif',
                        'imageUrl': imageUrl, // Simpan URL gambar di Firestore
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => KelolaUserPage()),
                      );
                    }
                  },
                  child: const Text(
                    'SIMPAN',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {bool isRequired = false, double fontSize = 14, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: fontSize),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fontSize,
                ),
              ),
          ],
        ),
        TextFormField(
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Pilih Peran',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontSize: 14),
      ),
      value: _selectedRole,
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue!;
        });
      },
      items: <String>['Kasir', 'Admin', 'Manajer']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 14)),
        );
      }).toList(),
    );
  }
}
