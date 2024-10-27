import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wikusamakasir_ukk/kelolameja.dart';

class TambahMejaPage extends StatefulWidget {
  @override
  _TambahMejaPageState createState() => _TambahMejaPageState();
}

class _TambahMejaPageState extends State<TambahMejaPage> {
  String? selectedStatus = 'Kosong'; 
  final TextEditingController kapasitasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tambah Meja',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor Meja Box
            Center(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<String>(
                  future: _getNextTableNumber(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      snapshot.data ?? '...',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Kapasitas Form
            Text(
              'Kapasitas',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: kapasitasController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                hintText: 'Masukkan Kapasitas',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Status Meja Label
            Text(
              'Status Meja',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Dropdown Status Meja
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.brown,
                  ),
                ),
              ),
              items: <String>['Kosong', 'Dipesan', 'Digunakan']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
            ),
            const SizedBox(height: 24),

            // Simpan Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Ambil nomor meja terbaru
                  final nomorMeja = await _getNextTableNumber();
                  // Simpan data ke Firebase
                  FirebaseFirestore.instance.collection('meja').add({
                    'no_meja': nomorMeja,
                    'kapasitas': kapasitasController.text,
                    'status': selectedStatus,
                  });
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KelolaMejaPage()),
                  );
                },
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan nomor meja berikutnya
  Future<String> _getNextTableNumber() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('meja').get();
    final mejaCount = querySnapshot.docs.length;
    return (mejaCount + 1).toString().padLeft(2, '0'); 
  }
}



