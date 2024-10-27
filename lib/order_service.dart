import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_model.dart';
import 'firebase_service.dart';

class OrderService {
  List<OrderItem> cartItems = [];
  Map<String, OrderItem> cartItemsMap = {};
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');

  void addItemToCart(OrderItem item) {
    if (cartItemsMap.containsKey(item.title)) {
      cartItemsMap[item.title]!.count += item.count;
    } else {
      cartItemsMap[item.title] = item;
    }
    cartItems = cartItemsMap.values.toList(); // Convert back to list if needed
  }

  // Menghapus item dari keranjang
  void removeItemFromCart(OrderItem item) {
    cartItems.removeWhere((cartItem) => cartItem.title == item.title);
  }

  // Menghitung total harga dari semua item dalam keranjang
  int calculateTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + item.getTotalPrice());
  }

  // Mengambil semua item dalam keranjang
  List<OrderItem> getCartItems() {
    return cartItems;
  }

  // Mengosongkan keranjang
  void clearCart() {
    cartItems.clear();
  }

  // Simpan pesanan ke Firebase
   Future<void> saveOrderToFirebase(Map<String, dynamic> orderData) async {
    try {
      // Ganti 'orders' dengan koleksi yang sesuai di Firebase
      await FirebaseFirestore.instance.collection('orders').add(orderData);
    } catch (e) {
      print("Error saving order: $e");
      throw e; // Anda dapat melemparkan error untuk ditangani di atas
    }
  }

Future<void> saveOrderHistoryToFirebase(order) async {
    try {
      final historyCollection = FirebaseFirestore.instance.collection('orderHistory');
      await historyCollection.add({
        'total': order.total,
        'time': order.time,
        'date': order.date,
        'status': order.status,
        'items': order.items.map((item) => item.toMap()).toList(),
      });
    } catch (e) {
      print('Error saving order history to Firebase: $e');
    }
  }


  Future<void> loadOrderFromFirebase() async {
    try {
      final data = await FirebaseService.loadOrders();
      cartItems = data.map<OrderItem>((item) => OrderItem.fromMap(item)).toList();
    } catch (e) {
      print('Error loading orders from Firebase: $e');
    }
  }

  // Mendapatkan daftar meja yang berstatus "KOSONG"
  // Misalnya ini menggunakan Firebase
  Future<List<String>> getAvailableTables() async {
    List<String> tables = [];
    try {
      // Ambil data meja dari database
      // Ganti dengan kode akses database yang sesuai
      var snapshot = await FirebaseFirestore.instance.collection('meja').where('status', isEqualTo: 'KOSONG').get();
      for (var doc in snapshot.docs) {
        tables.add(doc.data()['nomor_meja']); // Ganti 'nomor_meja' sesuai dengan field di database
      }
    } catch (e) {
      print('Error fetching tables: $e'); // Debugging error
    }
    return tables;
  }

}
