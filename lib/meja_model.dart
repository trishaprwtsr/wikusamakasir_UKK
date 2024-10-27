import 'package:cloud_firestore/cloud_firestore.dart';

class MejaModel {
  final String id;
  final String noMeja;
  final String kapasitas;
  final String status;

  MejaModel({
    required this.id,
    required this.noMeja,
    required this.kapasitas,
    required this.status,
  });

  factory MejaModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return MejaModel(
      id: snapshot.id,
      noMeja: data['no_meja'],
      kapasitas: data['kapasitas'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no_meja': noMeja,
      'kapasitas': kapasitas,
      'status': status,
    };
  }
}
