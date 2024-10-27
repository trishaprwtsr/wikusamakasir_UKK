import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wikusamakasir_ukk/dashboardadmin.dart';
import 'package:wikusamakasir_ukk/dashboardkasir2.dart';
import 'package:wikusamakasir_ukk/dashboardmanager.dart';
import 'package:wikusamakasir_ukk/kelolauser.dart';
import 'package:wikusamakasir_ukk/strukpesanan.dart';
import 'landingpage.dart'; // Import kelas LandingPage dari landingpage.dart

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inisialisasi Firebase di dalam FutureBuilder
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Cek jika inisialisasi Firebase selesai
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wikusama Cafe',
            theme: ThemeData(
              primarySwatch: Colors.brown,
            ),
            home: LandingPage(), // Halaman pertama aplikasi
          );
        }

        // Jika inisialisasi masih berlangsung, tampilkan loading screen
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
