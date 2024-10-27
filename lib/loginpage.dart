import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamakasir_ukk/dashboardadmin.dart';
import 'package:wikusamakasir_ukk/dashboardkasir2.dart';
import 'package:wikusamakasir_ukk/dashboardmanager.dart';
import 'package:wikusamakasir_ukk/welcomepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedRole;

  final _formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    // Validasi form sebelum proses login
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final role = selectedRole;

      try {
        // Query Firestore untuk mencari user yang cocok
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .where('role', isEqualTo: role)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // Jika user ditemukan, navigasi sesuai peran
          if (role == 'Kasir') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardKasir2()),
            );
          } else if (role == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardAdmin()),
            );
          } else if (role == 'Manajer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardManager()),
            );
          }
        } else {
          // Jika tidak ada user yang cocok, tampilkan pesan error
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Gagal'),
              content: const Text('Email, kata sandi, atau peran salah.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print("Error logging in: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                  height: 230,
                  width: 230,
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/openingkopi.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6A4234),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Kita sudah bertemu!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    hintText: 'Masukkan Email',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    hintText: 'Masukkan Kata Sandi',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Kata sandi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Dropdown for Role Selection
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    hintText: 'Pilih Peran',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: selectedRole,
                  items: ['Kasir', 'Admin', 'Manajer']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role, style: GoogleFonts.poppins()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Peran tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: const Color(0xFF6A4234),
                  ),
                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
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
}
