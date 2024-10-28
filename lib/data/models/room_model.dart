import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  RoomModel({
    required this.description,
    required this.hotelID,
    required this.photos,
    required this.roomType,
    required this.price,
  });
  final String description;
  final String hotelID;
  final List<String> photos;
  final String roomType;
  final double price;

  factory RoomModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return RoomModel(
        description: data?['description'],
        hotelID: data?['hotelId'],
        photos: data?['photos'].cast<String>(),
        roomType: data?['roomType'],
        price: data?['price'].toDouble(), // Chuyển đổi sang double nếu cần thiết
);
  }
}
