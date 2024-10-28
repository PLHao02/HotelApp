import 'package:flutter/material.dart';

class SelectCityScreen extends StatefulWidget {
  static const String routeName = '/select-city'; // Đặt tên route cho màn hình

  @override
  _SelectCityScreenState createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  String? selectedCity; // Biến lưu trữ thành phố được chọn

  List<String> cities = [
    // Danh sách thành phố
    'Hà Nội',
    'TP Hồ Chí Minh',
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
