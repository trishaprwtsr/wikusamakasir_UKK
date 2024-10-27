import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/dashboardkasir2.dart';
import 'package:wikusamakasir_ukk/order_history.dart';
import 'package:wikusamakasir_ukk/order_model.dart';

class RiwayatPesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE7),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Riwayat Pesanan',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardKasir2()),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orderHistory').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading order history: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No order history available.'));
          }

          final orders = snapshot.data!.docs.map((doc) {
            return Order.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          );
        },
      ),
    );
  }
}

class Order {
  final int total;
  final String time;
  final String date;
  final bool status;
  final List<OrderItem> items;

  Order({
    required this.total,
    required this.time,
    required this.date,
    required this.status,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'time': time,
      'date': date,
      'status': status,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      total: map['total'] ?? 0,
      time: map['time'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? false,
      items: (map['items'] as List).map((item) => OrderItem.fromMap(item)).toList(),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Rp. ${order.total}',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${order.time}    ${order.date}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Icon(
              order.status ? Icons.check_circle : Icons.cancel,
              color: order.status ? Colors.green : Colors.red,
              size: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
