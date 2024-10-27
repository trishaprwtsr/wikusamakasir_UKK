class MenuModel {
  String id;
  String name;
  String code;
  double basePrice;
  double salePrice;
  String category;
  double weight;
  String unit;
  String description;
  String imageUrl;


  MenuModel({
    required this.id,
    required this.name,
    required this.code,
    required this.basePrice,
    required this.salePrice,
    required this.category,
    required this.weight,
    required this.unit,
    required this.description,
    required this.imageUrl,
    
  });

  // Fungsi untuk mengubah data dari JSON ke object
  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      basePrice: map['basePrice'].toDouble() ?? 0.0,
      salePrice: map['salePrice'].toDouble() ?? 0.0,
      category: map['category'] ?? '',
      weight: map['weight'].toDouble() ?? 0.0,
      unit: map['unit'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Fungsi untuk mengubah object ke dalam format JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'basePrice': basePrice,
      'salePrice': salePrice,
      'category': category,
      'weight': weight,
      'unit': unit,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
