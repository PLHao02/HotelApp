import 'package:flutter/material.dart';

class select_city_screen extends StatefulWidget {
  static const String routeName = '/select-city'; // Đặt tên route cho màn hình

  @override
  _select_city_screenState createState() => _select_city_screenState();
}

class _select_city_screenState extends State<select_city_screen> {
  String? selectedCity; // Biến lưu trữ thành phố được chọn
  List<String> cities = [
    // Danh sách thành phố
    'Hà Nội',
    'Hồ Chí Minh',
    'Đà Nẵng',
    // ... Thêm thành phố khác
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn thành phố'), // Tiêu đề cho màn hình
      ),
      body: ListView.builder(
        // Danh sách thành phố
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]), // Hiển thị tên thành phố
            onTap: () {
              setState(() {
                // Cập nhật state khi chọn thành phố
                selectedCity = cities[index];
              });
              Navigator.pop(
                  context, selectedCity); // Trả về thành phố được chọn
            },
          );
        },
      ),
    );
  }
}
