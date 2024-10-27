import 'package:flutter/material.dart';
import 'package:wikusamakasir_ukk/user_model.dart'; // Import UserModel jika ada
import 'package:wikusamakasir_ukk/user_service.dart'; // Import UserService

class EditUserPage extends StatelessWidget {
  final UserModel user;
  final UserService firebaseService = UserService(); // Inisialisasi UserService

  EditUserPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: user.name);
    final TextEditingController emailController = TextEditingController(text: user.email);
    String? selectedRole = user.role; // Role yang dipilih
    String? selectedStatus = user.status; // Status yang dipilih

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF8EFE7),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: <String>['Admin', 'Kasir', 'Manager'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedRole = newValue; // Update selected role
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: <String>['Aktif', 'Non-Aktif'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedStatus = newValue; // Update selected status
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, // Membuat tombol mengisi lebar penuh
              child: ElevatedButton(
                onPressed: () async {
                  // Update user data
                  await firebaseService.updateUser(UserModel(
                    id: user.id, 
                    name: nameController.text,
                    email: emailController.text,
                    role: selectedRole!,
                    status: selectedStatus!,
                  ));

                  // Kembali ke halaman sebelumnya setelah update
                  Navigator.pop(context);
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white), 
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
