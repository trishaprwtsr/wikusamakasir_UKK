import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Simpan order ke Firestore
  static Future<void> saveOrder(Map<String, dynamic> orderData) async {
    try {
      await _firestore.collection('orders').add(orderData);
    } catch (e) {
      print('Error saving order: $e');
      
    }
  }

  // Ambil semua order dari Firestore
  static Future<List<Map<String, dynamic>>> loadOrders() async {
    List<Map<String, dynamic>> orders = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('orders').get();
      for (var doc in querySnapshot.docs) {
        orders.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error loading orders: $e');
      
    }
    return orders;
  }

  // Ambil semua meja dengan status dari Firestore
  static Future<List<Map<String, dynamic>>> loadTables() async {
    List<Map<String, dynamic>> tables = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tables').get();
      for (var doc in querySnapshot.docs) {
        tables.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error loading tables: $e');
      
    }
    return tables;
  }
}
