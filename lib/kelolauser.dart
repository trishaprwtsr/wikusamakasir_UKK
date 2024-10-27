import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/edituser.dart';
import 'package:wikusamakasir_ukk/tambahuser.dart';
import 'package:wikusamakasir_ukk/user_service.dart';
import 'package:wikusamakasir_ukk/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KelolaUserPage extends StatelessWidget {
  final UserService firebaseService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      appBar: AppBar(
        title: Text(
          'Kelola Data User',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFF8EFE7),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari user...',
                hintStyle: GoogleFonts.poppins(fontSize: 12),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var users = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      String imageUrl = user.data().containsKey('imageUrl') &&
                              user['imageUrl'] != null
                          ? user['imageUrl']
                          : 'assets/default_profile.png';
                      return userCard(
                        context,
                        id: user.id,
                        imageUrl: imageUrl,
                        name: user['name'],
                        email: user['email'],
                        role: user['role'],
                        status: user['status'],
                        imageAsset: '',
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TambahUserPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Tambah User',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(
    BuildContext context, {
    required String id,
    required String? imageUrl,
    required String name,
    required String email,
    required String role,
    required String status,
    required String imageAsset,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 60, // Adjusted width
                      height: 60, // Adjusted height
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 80, // Adjusted icon size for consistency
                          color: Colors.grey,
                        );
                      },
                    )
                  : Icon(
                      Icons.person,
                      size: 20, // Adjusted icon size
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Peran: $role',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Status: $status',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(
                          user: UserModel(
                            id: id,
                            name: name,
                            email: email,
                            role: role,
                            status: status,
                            imageUrl: imageUrl,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await firebaseService.deleteUser(id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
