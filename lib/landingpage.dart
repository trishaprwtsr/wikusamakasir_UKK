import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/loginpage.dart'; // Import Google Fonts


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar di atas, lebih kecil dan diatur ukurannya
            Container(
              height: 400, // Atur tinggi gambar
              width: 400,  // Atur lebar gambar (misal kotak)
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/openingkopi.png'), // Ganti dengan path ke gambar lokal
                  fit: BoxFit.contain, // Menyesuaikan gambar dengan container
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak antara gambar dan teks besar
            // Teks besar
            Text(
              'Ayo, Kelola sistem dengan mudah',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10), // Jarak antara teks besar dan teks kecil
            // Teks kecil
            Text(
              'Login sekarang untuk mulai mengatur operasional cafe',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30), // Jarak antara teks kecil dan tombol
            // Tombol
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol ditekan, navigasi ke LoginPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Pindah ke halaman LoginPage
                );
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.white), // Ikon panah setelah teks
              label: Text(
                'Mulai',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF55433C), // Warna tombol sesuai (#55433C)
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20), // Jarak antara tombol dan bawah layar
          ],
        ),
      ),
    );
  }
}
