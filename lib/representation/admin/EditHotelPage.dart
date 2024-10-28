// Trang chỉnh sửa khách sạn
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_appv1/representation/admin/Hotel.dart';

class EditHotelPage extends StatefulWidget {
  final Hotel hotel;

  EditHotelPage({required this.hotel});

  @override
  _EditHotelPageState createState() => _EditHotelPageState();
}

class _EditHotelPageState extends State<EditHotelPage> {
  // Thêm các trường và hàm để chỉnh sửa thông tin khách sạn
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa khách sạn'),
      ),
      body: Center(
        // Form để chỉnh sửa thông tin khách sạn
        // ...
      ),
    );
  }
}

// Phương thức để xóa khách sạn
void _deleteHotel(String hotelId) {
  FirebaseFirestore.instance.collection('Hotels').doc(hotelId).delete()
    .then((value) {
      // Xóa thành công, thực hiện các hành động phù hợp (vd: thông báo)
    })
    .catchError((error) {
      // Xảy ra lỗi khi xóa, xử lý lỗi nếu cần thiết
    });
}
