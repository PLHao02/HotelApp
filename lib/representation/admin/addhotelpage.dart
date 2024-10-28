import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateRoomScreen extends StatefulWidget {
  final String hotelId; // ID của khách sạn

  CreateRoomScreen({required this.hotelId});

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  String _roomType = '';
  String _description = '';
  double _price = 0.0;
  List<String> _photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo phòng mới'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Loại phòng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập loại phòng';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _roomType = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Giá phòng'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá phòng';
                  }
                  try {
                    double price = double.parse(value);
                    if (price <= 0) {
                      return 'Giá phòng phải lớn hơn 0';
                    }
                    return null;
                  } catch (e) {
                    return 'Giá phòng không hợp lệ';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      _price = double.parse(value);
                    }
                  });
                },
              ),
              SizedBox(height: 16.0),
              // Nút chọn ảnh
              // ElevatedButton(
              //   onPressed: () async {
              //     // Chọn ảnh từ thư viện
              //     final pickedFiles = await ImagePicker().pickMultipleImages(
              //       maxImages: 5,
              //     );

              //     if (pickedFiles != null) {
              //       setState(() {
              //         _photos = pickedFiles.map((file) => file.path).toList();
              //       });
              //     }
              //   },
              //   child: Text('Chọn ảnh'),
              // ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Tạo phòng mới
                    _createRoom();
                  }
                },
                child: Text('Tạo phòng'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createRoom() async {
    CollectionReference roomsRef = FirebaseFirestore.instance.collection('Rooms');

    await roomsRef.doc().set({
      'hotelId': widget.hotelId,
      'roomType': _roomType,
      'description': _description,
      'price': _price,
      'photos': _photos,
    });

    // Quay lại trang danh sách phòng
    Navigator.pop(context);
  }
}
