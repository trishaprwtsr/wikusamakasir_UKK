import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/order_history.dart';
import 'package:wikusamakasir_ukk/order_model.dart';
import 'package:wikusamakasir_ukk/order_service.dart';
import 'package:wikusamakasir_ukk/pesanansukses.dart';
import 'package:wikusamakasir_ukk/riwayatpesanan.dart';
import 'package:wikusamakasir_ukk/pesanan.dart'; 

class PesananPage extends StatefulWidget {
  final List<OrderItem> cartItems; // Mengambil cartItems sebagai List<OrderItem>

  PesananPage({required this.cartItems});

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final OrderService orderService = OrderService();
  String? selectedTable;
  List<String> availableTables = ["02", "04", "01", "07", "06"]; // Nomor meja tetap

  @override
  void initState() {
    super.initState();
    
    for (var item in widget.cartItems) {
      orderService.addItemToCart(item);
    }
  }

  int totalPrice() {
    return widget.cartItems.fold(0, (total, item) => total + item.getTotalPrice());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF8EFE7),
      ),
      body: Container(
        color: Color(0xFFF8EFE7),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return _buildOrderItem(item);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButtonFormField<String>(
                value: selectedTable,
                items: availableTables
                    .map((table) => DropdownMenuItem(
                          value: table,
                          child: Text('Meja $table'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTable = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Pilih Nomor Meja',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \nRp. ${totalPrice()}',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      backgroundColor: Colors.brown[700],
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onPressed: () async {
                    final newOrder = Order(
                      total: totalPrice(),
                      time: TimeOfDay.now().format(context),
                      date: DateTime.now().toIso8601String().split('T').first,
                      status: true,
                      items: widget.cartItems,
                    );

                    await orderService.saveOrderToFirebase(newOrder.toMap());
                    await orderService.saveOrderHistoryToFirebase(newOrder);
                    orderHistory.add(newOrder);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PesananSukses()),
                    );
                  },
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              item.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp. ${item.price}',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[700], 
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white), // Warna ikon
                    onPressed: () {
                      setState(() {
                        if (item.count > 1) {
                          item.count--;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    item.count.toString(),
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[700], 
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white), // Warna ikon
                    onPressed: () {
                      setState(() {
                        item.count++;
                      });
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
