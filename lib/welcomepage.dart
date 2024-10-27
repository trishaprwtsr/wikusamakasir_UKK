import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/dashboardkasir2.dart';// Import halaman DashboardKasir

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar centang di atas
              Container(
                height: 150, // Atur tinggi gambar
                width: 150,  // Atur lebar gambar
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logosukses.png'), // Path ke gambar centang
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 30), // Jarak antara gambar dan teks besar
              
              // Teks besar "Selamat Datang!"
              Text(
                'Selamat Datang!',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4A2C2A), // Warna teks
                ),
              ),
              const SizedBox(height: 10), // Jarak antara teks besar dan teks kecil
              
              // Teks kecil deskripsi
              Text(
                'Siap mempermudah pesanan pelanggan dengan cepat dan efisien',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50), 

              // Tombol Masuk Beranda
              ElevatedButton.icon(
                onPressed: () {
                  // Navigasi ke halaman DashboardKasir
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardKasir2()),
                  );
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white), // Ikon panah
                label: Text(
                  'Masuk Beranda',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xFF6A4234), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
