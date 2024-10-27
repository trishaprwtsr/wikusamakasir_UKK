import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/meja_model.dart';
import 'package:wikusamakasir_ukk/meja_service.dart';

class EditMejaPage extends StatefulWidget {
  final MejaModel meja;

  EditMejaPage({required this.meja});

  @override
  _EditMejaPageState createState() => _EditMejaPageState();
}

class _EditMejaPageState extends State<EditMejaPage> {
  final MejaService mejaService = MejaService();
  late TextEditingController noMejaController;
  late TextEditingController kapasitasController;
  late String status;

  @override
  void initState() {
    super.initState();
    noMejaController = TextEditingController(text: widget.meja.noMeja);
    kapasitasController = TextEditingController(text: widget.meja.kapasitas);
    status = widget.meja.status;
  }

  @override
  void dispose() {
    noMejaController.dispose();
    kapasitasController.dispose();
    super.dispose();
  }

  void _updateMeja() {
    final updatedMeja = MejaModel(
      id: widget.meja.id,
      noMeja: noMejaController.text,
      kapasitas: kapasitasController.text,
      status: status,
    );

    mejaService.updateMeja(widget.meja.id, updatedMeja).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors here (e.g., show a snackbar)
      print('Failed to update meja: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Meja',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: noMejaController,
              decoration: InputDecoration(
                labelText: 'Nomor Meja',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: kapasitasController,
              decoration: InputDecoration(
                labelText: 'Kapasitas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: status,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: <String>['Kosong', 'Dipesan', 'Digunakan'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  status = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateMeja,
              child: Text(
                'Simpan Perubahan',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
