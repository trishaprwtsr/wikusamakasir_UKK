import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/dashboardkasir2.dart';
import 'package:wikusamakasir_ukk/riwayatpesanan.dart';
import 'package:wikusamakasir_ukk/strukpesanan.dart';

class PesananSukses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EDE5), // Warna latar belakang
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Gambar centang dari assets
              Image.asset(
                'assets/logosukses.png', // Ganti dengan path gambar centang di assets
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Kerja Bagus!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700],
                ),
              ),
              Text(
                'Transaksi Berhasil',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(flex: 1),
              // Tombol Transaksi baru
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RiwayatPesananScreen()), // Navigate to RiwayatPesananScreen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Center(
                  child: Text(
                    'Lihat Riwayat Pesanan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // Tombol Cetak Struk
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        
                        // Aksi ketika tombol Cetak Struk ditekan
                      },
                      icon: const Icon(Icons.print),
                      label: Text(
                        'Cetak Struk',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.brown[400],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.brown[400]!),
                        foregroundColor: Colors.brown[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      // Aksi ketika ikon pengaturan printer ditekan
                    },
                    icon: const Icon(Icons.settings),
                    color: Colors.brown[400],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Tombol Lihat Struk
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StrukPesanan()), 
                  );// Aksi ketika tombol Lihat Struk ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.brown[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Center(
                  child: Text(
                    'Lihat Struk',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.brown[400],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              // Tombol Kembali ke Beranda
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardKasir2()), // Navigate to KelolaMenu page
                );
                  // Aksi ketika tombol Kembali ke Beranda ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Center(
                  child: Text(
                    'Kembali ke Beranda',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
