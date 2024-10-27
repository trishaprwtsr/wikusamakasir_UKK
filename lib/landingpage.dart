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

            Container(
              height: 400, 
              width: 400,  
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/openingkopi.png'), 
                  fit: BoxFit.contain, 
                ),
              ),
            ),
            const SizedBox(height: 20), 
            Text(
              'Ayo, Kelola sistem dengan mudah',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Login sekarang untuk mulai mengatur operasional cafe',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30), 
            ElevatedButton.icon(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), 
                );
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: Text(
                'Mulai',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF55433C), 
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
