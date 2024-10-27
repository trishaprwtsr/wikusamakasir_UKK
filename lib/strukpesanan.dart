import 'package:flutter/material.dart';
import 'package:wikusamakasir_ukk/pesanansukses.dart';

class StrukPesanan extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE7), 
        elevation: 0,
        centerTitle: true, 
        title: const Text(
          'Lihat Struk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold 
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PesananSukses()),
            );
          },
        ),
      ),

      body: Container(
        color: const Color(0xFFF8EFE7), 
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                const Text(
                  'Wikusama cafe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Jalan Siap Ngoding Tiap Hari No.92',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2024 - 20 - 09'),
                    Text('William Samuel'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('10 : 18 : 36'),
                    Text('Meja No. 05'),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                itemRow('Cappucino (ml)', '1x 14.000', 'Rp. 14.000'),
                itemRow('Matcha Latte (ml)', '1x 18.000', 'Rp. 18.000'),
                const Divider(thickness: 1),
                totalRow('Total', 'Rp. 32.000'),
                totalRow('Bayar', 'Rp. 32.000'),
                totalRow('Kembali', 'Rp. 0'),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                
                Center(
                  child: Column(
                    children: [
                      const Text(
                        '• Link Kritik dan Saran :',
                        style: TextStyle(color: Colors.red),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Buka link
                        },
                        child: const Text(
                          'wikusamacafe.com/f/1992',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Simpan struk
                      },
                      icon: Icon(Icons.save),
                      label: Text('Simpan'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Bagikan struk
                      },
                      icon: Icon(Icons.share),
                      label: Text('Bagikan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemRow(String name, String qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(qty),
          Text(price),
        ],
      ),
    );
  }

  Widget totalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}