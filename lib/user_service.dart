import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UserService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan data user dari Firebase
  Stream<List<UserModel>> getUsers() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Menambahkan data user baru
  Future<void> addUser(UserModel user) {
    return _usersCollection.add({
      'name': user.name,
      'email': user.email,
      'role': user.role,
      'status': user.status,
      // 'isActive': user.isActive ?? true, // Set nilai default true jika tidak disediakan
    });
  }

  // Mengupdate data user
  Future<void> updateUser(UserModel user) async {
  print('Updating user: ${user.id}, ${user.name}, ${user.email}, ${user.role}, ${user.status}');
  await _firestore.collection('users').doc(user.id).update({
    'name': user.name,
    'email': user.email,
    'role': user.role,
    'status': user.status,
  });
}

  // Menghapus user
  Future<void> deleteUser(String id) {
    return _usersCollection.doc(id).delete();
  }
}
