import 'package:cloud_firestore/cloud_firestore.dart';
import 'meja_model.dart';

class MejaService {
  final CollectionReference mejaCollection =
      FirebaseFirestore.instance.collection('meja');

  // Mendapatkan stream meja dari Firestore
  Stream<List<MejaModel>> getMejaStream() {
    return mejaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MejaModel.fromSnapshot(doc);
      }).toList();
    });
  }

  // Menambahkan meja baru
  Future<void> addMeja(MejaModel meja) async {
    await mejaCollection.add(meja.toMap());
  }

  // Menghapus meja
  Future<void> deleteMeja(String id) async {
    await mejaCollection.doc(id).delete();
  }

  // Mengedit meja
  Future<void> updateMeja(String id, MejaModel meja) async {
    await mejaCollection.doc(id).update(meja.toMap());
  }
}
