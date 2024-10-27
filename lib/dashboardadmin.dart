import 'package:flutter/material.dart';
import 'package:wikusamakasir_ukk/landingpage.dart';

// Import the pages for navigation
import 'kelolauser.dart';
import 'kelolamenu.dart';
import 'kelolameja.dart';

class DashboardAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Admin',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,  // Set the font size for the title
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AdminOptionCard(
              icon: Icons.person_outline,
              title: 'Pengelolaan Data User',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaUserPage()), // Navigate to KelolaUser page
                );
              },
              width: 500,  // Set width here
              height: 80, // Set height here
              iconSize: 33,  // Set the icon size
              fontSize: 13,  // Set the font size for the card title
            ),
            const SizedBox(height: 16),
            AdminOptionCard(
              icon: Icons.fastfood_outlined,
              title: 'Pengelolaan Data Minuman & Makanan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KelolaMenu()), // Navigate to KelolaMenu page
                );
              },
              width: 500,  // Set width here
              height: 80, // Set height here
              iconSize: 33,  // Set the icon size
              fontSize: 12,  // Set the font size for the card title
            ),
            const SizedBox(height: 16),
            AdminOptionCard(
              icon: Icons.table_chart_outlined,
              title: 'Pengelolaan Data Meja',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KelolaMejaPage()), // Navigate to KelolaMeja page
                );
              },
              width: 500,  // Set width here
              height: 80, // Set height here
              iconSize: 33,  // Set the icon size
              fontSize: 13,  // Set the font size for the card title
            ),
            Spacer(), // Push the Logout button to the bottom
            // Logout button
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()), // Navigate to WelcomePage
                );
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white, size: 24), // Logout icon
                    const SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16), // Add space at the bottom
          ],
        ),
      ),
    );
  }
}

class AdminOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double iconSize; // New parameter for icon size
  final double fontSize; // New parameter for text size

  AdminOptionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.width,
    required this.height,
    required this.iconSize, // New parameter
    required this.fontSize, // New parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize, color: Colors.black54), // Use icon size parameter
                SizedBox(width: 16), // Space between icon and text
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize, // Use font size parameter
                    fontWeight: FontWeight.w600,
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
