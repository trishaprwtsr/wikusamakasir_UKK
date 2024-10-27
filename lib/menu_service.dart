import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'menu_model.dart';

class MenuService {
  final CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('menus');

  // Tambah produk baru
  Future<void> addMenu(MenuModel menu, File? imageFile) async {
    try {
      // Upload gambar ke Firebase Storage jika ada
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _uploadImage(imageFile);
      }

      // Buat ID dokumen baru
      DocumentReference docRef = menuCollection.doc();
      menu.id = docRef.id;

      // Menyimpan data ke Firestore
      await docRef.set({
        'id': menu.id,
        'name': menu.name,
        'code': menu.code,
        'basePrice': menu.basePrice,
        'salePrice': menu.salePrice,
        'category': menu.category,
        'weight': menu.weight,
        'unit': menu.unit,
        'description': menu.description,
        'imageUrl': imageUrl ?? menu.imageUrl,
      });
    } catch (e) {
      throw Exception('Gagal menambah menu: $e');
    }
  }

  Stream<List<MenuModel>> getAllMenus() {
    return menuCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MenuModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Fungsi untuk upload gambar ke Firebase Storage
  Future<String> _uploadImage(File imageFile) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('menu_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Gagal upload gambar: $e');
    }
  }

  // Mengupdate menu
  Future<void> updateMenu(MenuModel menu) async {
    try {
      await menuCollection.doc(menu.id).update(menu.toMap());
    } catch (e) {
      throw Exception('Gagal mengupdate menu: $e');
    }
  }

  // Menghapus menu
  Future<void> deleteMenu(String id) async {
    try {
      await menuCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Gagal menghapus menu: $e');
    }
  }
}
