import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createHotelsAndRooms() async {
  // Tạo bảng Hotels
  CollectionReference hotelsRef = FirebaseFirestore.instance.collection('Hotels');

  await hotelsRef.doc().set({
    'name': 'Khách sạn XYZ',
    'address': '123 Phố ABC',
    'city': 'Thành phố XYZ',
    'description': 'Một khách sạn tuyệt vời với các phòng thoải mái và dịch vụ tuyệt vời.',
    'photos': ['https://cdn3.ivivu.com/2014/01/SUPER-DELUXE2.jpg'],
    // 'rooms': [], // Mảng tham chiếu đến các tài liệu trong bảng Rooms
    'toado': '10.823824,106.691056',
 // Thêm tọa độ
  });

  // Tạo bảng Rooms
  CollectionReference roomsRef = FirebaseFirestore.instance.collection('Rooms');

  await roomsRef.doc().set({
    'hotelId': 'idHotel-của-khách-sạn', // Tham chiếu đến tài liệu trong bảng Hotels
    'roomType': 'Đơn',
    'description': 'Một phòng đơn thoải mái với giường đôi và phòng tắm riêng.',
    'price': 100, // Giá phòng cho một đêm
    'photos': ['https://cdn3.ivivu.com/2014/01/SUPER-DELUXE2.jpg'],
  });
}
