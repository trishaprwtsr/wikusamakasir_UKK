import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamakasir_ukk/landingpage.dart'; // Firestore for Firebase integration

class DashboardManager extends StatefulWidget {
  @override
  _DashboardManagerState createState() => _DashboardManagerState();
}

class _DashboardManagerState extends State<DashboardManager> {
  DateTime selectedDate = DateTime.now(); // Default to today's date
  int totalTransaksi = 0; // Total transactions for selected date
  int totalPendapatan = 0; // Total revenue for selected date

  // Select date using DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Use currently selected date
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal',
      fieldLabelText: 'Masukkan Tanggal',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      _fetchTransactionData(selectedDate); // Update transactions based on selected date
    }
  }

  // Fetch transaction data for selected date
  Future<void> _fetchTransactionData(DateTime date) async {
    final dateFormatted = DateFormat('yyyy-MM-dd').format(date); // Format date to match Firestore format

    final querySnapshot = await FirebaseFirestore.instance
        .collection('orderHistory')
        .where('date', isEqualTo: dateFormatted) // Filter by date
        .get();

    setState(() {
      totalTransaksi = querySnapshot.docs.length;
      totalPendapatan = querySnapshot.docs.fold(0, (sum, doc) => sum + (doc['total'] as int));
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactionData(selectedDate); // Initialize with today’s data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/alvaro.jpeg'),
                    radius: 30,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Pagi,',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        'Alvaro',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()), 
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context), // Show date picker
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    labelText: 'Pilih Tanggal',
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  child: Text(
                    DateFormat('dd MMMM').format(selectedDate),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryCard('Total Transaksi', '$totalTransaksi', Icons.receipt_long, Colors.green),
                  _buildSummaryCard('Pendapatan', 'Rp. $totalPendapatan', Icons.attach_money, Colors.orange),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Data Transaksi',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orderHistory')
                      .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate)) // Filter by selected date
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No transactions for this date.'));
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Card(
                          elevation: 3, 
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                          color: Colors.white, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              'Rp. ${data['total']}',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${data['time']} - ${data['date']}',
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                            ),
                            trailing: Icon(
                              data['status'] ? Icons.check_circle : Icons.cancel,
                              color: data['status'] ? Colors.green : Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for summary cards
  Widget _buildSummaryCard(String title, String amount, IconData icon, Color iconColor) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 40),
            SizedBox(height: 10),
            Text(title, style: GoogleFonts.poppins(fontSize: 14)),
            SizedBox(height: 5),
            Text(amount, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
