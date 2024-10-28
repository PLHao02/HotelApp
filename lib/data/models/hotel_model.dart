import 'package:cloud_firestore/cloud_firestore.dart';

class HotelModel {
  final String id;
  final String photos;
  final String name;
  final String address;
  final int star;
  final int price;

  HotelModel({
    required this.id,
    required this.photos,
    required this.name,
    required this.address,
    required this.star,
    required this.price,
  });

  factory HotelModel.fromMap(Map<String, dynamic> map) => HotelModel(
        id: map['id'] as String,
        photos: map['photos'] as String,
        name: map['name'] as String,
        address: map['address'] as String,
        star: map['star'] as int,
        price: map['price'] as int,
      );
  HotelModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : id = doc['id'],
        photos = doc['photos'],
        // Lấy ảnh đầu tiên nếu có
        name = doc['name'],
        address = doc['address'],
        star = doc['star'],
        price = doc['price'];
}
