import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_appv1/representation/admin/HotelRoomListPage.dart';
import 'package:image_picker/image_picker.dart';

class HotelsListPage extends StatefulWidget {
  @override
  _HotelsListPageState createState() => _HotelsListPageState();
}

class _HotelsListPageState extends State<HotelsListPage> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _photosController = TextEditingController();
  final _toadoController = TextEditingController();
  final _priceController = TextEditingController();
  final _starController = TextEditingController();


  final _imagePicker = ImagePicker();
  File? _hotelImageFile;

  Future<void> _pickHotelImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _hotelImageFile = File(pickedFile.path);
      });
    }
  }

  void _editHotel(String hotelId) async {
    // Fetch current hotel data
    final hotelRef = _firestore.collection('Hotels').doc(hotelId);
    final hotelDoc = await hotelRef.get();
    final hotelData = hotelDoc.data()! as Map<String, dynamic>;

    // Update state variables with current hotel data
    _nameController.text = hotelData['name'];
    _addressController.text = hotelData['address'];
    _cityController.text = hotelData['city'];
    _descriptionController.text = hotelData['description'];
  _photosController.text = hotelData['photos']; 
    // _photosController.text = (hotelData['photos'] as List<dynamic>).join(','); // Convert array to comma-separated string if needed
// Assuming a single image URL
    _toadoController.text = hotelData['toado'];
    _priceController.text = hotelData['price'];
    _starController.text = hotelData['star'];


    _hotelImageFile = null; // Reset image file

    // Show edit dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa khách sạn'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Tên khách sạn'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên khách sạn';
                      }
                      return null;
                    },
                  ),
                  // ... (Other input fields: address, city, description, photos, toado)
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Địa chỉ'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập địa chỉ khách sạn';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'Thành phố '),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên thành phố của khách sạn';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Mô tả khách sạn'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mổ tả khách sạn';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Giá khách sạn'),
                    keyboardType: TextInputType.number, // Set keyboard for numbers
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập giá khách sạn';
                      }
                      if (int.tryParse(value) == null) { // Check if valid integer
                        return 'Giá khách sạn phải là số';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _starController,
                    decoration: InputDecoration(labelText: 'Sao khách sạn'),
                    keyboardType: TextInputType.number, // Set keyboard for numbers
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập sao khách sạn';
                      }
                      if (int.tryParse(value) == null) { // Check if valid integer
                        return 'Sao khách sạn phải là số';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      if (_hotelImageFile != null)
                        Image.file(_hotelImageFile!, width: 100, height: 100)
                      else
                        SizedBox(width: 100, height: 100),
                      TextButton(
                        onPressed: _pickHotelImage,
                        child: Text('Chọn ảnh'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateHotel(hotelId);
                  Navigator.pop(context);
                }
              },
              child: Text('Cập nhật'),
            ),
          ],
        );
      },
    );
  }

  void _showAddHotelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm khách sạn'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Tên khách sạn'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên khách sạn';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Địa chỉ'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập địa chỉ';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'Thành phố'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập thành phố';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Mô tả'),
                    maxLines: 5,
                  ),
                  // TextFormField(
                  //   controller: _photosController,
                  //   decoration: InputDecoration(labelText: 'URL ảnh'),
                  //   validator: (value) {
                  //     if (value != null && !value.startsWith('http')) {
                  //       return 'URL ảnh không hợp lệ';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: _toadoController,
                    decoration: InputDecoration(labelText: 'Tọa độ'),
                    validator: (value) {
                      if (value != null && !value.contains(',')) {
                        return 'Tọa độ không hợp lệ (ví dụ: 10.823824,106.691056)';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Giá'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập giá';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _starController,
                    decoration: InputDecoration(labelText: 'Sao'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số sao';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      if (_hotelImageFile != null)
                        Image.file(_hotelImageFile!, width: 100, height: 100)
                      else
                        SizedBox(width: 100, height: 100),
                      TextButton(
                        onPressed: _pickHotelImage,
                        child: Text('Chọn ảnh'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addHotel();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Thêm'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addHotel() async {
  String? hotelImageURL;
  if (_hotelImageFile != null) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('hotels/${_hotelImageFile!.path.split('/').last}');
    await ref.putFile(_hotelImageFile!);
    hotelImageURL = await ref.getDownloadURL();
  }
final newHotelRef = _firestore.collection('Hotels').doc(); // Tạo tham chiếu tài liệu
  final String hotelId = Uuid().v4();
  // final newHotelRef = _firestore.collection('Hotels').doc();

  final hotelData = {
    'id': hotelId,
    'name': _nameController.text,
    'address': _addressController.text,
    'city': _cityController.text,
    'description': _descriptionController.text,
    'photos': hotelImageURL, // Directly store the URL
    'toado': _toadoController.text,
    'price': int.tryParse(_priceController.text) ?? 0,
    'star': int.tryParse(_starController.text) ?? 0 ,
  'isFavorite': false // Add this line

  };

  // await newHotelRef.set(hotelData); // Use .set to include the ID

  await _firestore.collection('Hotels').doc(hotelId).set(hotelData);
    // 'isFavorite': !hotelData['isFavorite'] // Toggle the current value

    _nameController.clear();
    _addressController.clear();
    _cityController.clear();
    _descriptionController.clear();
    _photosController.clear();
    _toadoController.clear();
    _hotelImageFile = null;
    _priceController.clear();
    _starController.clear();


    setState(() {});
  }

  // Hàm xóa khách sạn
  void _deleteHotel(String hotelId) async {
  final hotelRef = _firestore.collection('Hotels').doc(hotelId);
  final hotelData = await hotelRef.get();
  final photosRaw = (hotelData.data()! as Map<String, dynamic>)['photos'];

  // Xử lý cả hai trường hợp tiềm ẩn:
  if (photosRaw is String) { // URL hình ảnh đơn
    try {
      await FirebaseStorage.instance.refFromURL(photosRaw).delete(); 
    } catch (e) {
      print('Error deleting image: $e');
    }
  } else if (photosRaw is List) { // Mảng các URL có thể
    for (final photoUrl in photosRaw.whereType<String>()) {
      try {
        await FirebaseStorage.instance.refFromURL(photoUrl).delete(); 
      } catch (e) {
        print('Error deleting image: $e');
      }
    } 
  }

  // Xóa tài liệu khách sạn
  await hotelRef.delete(); 

  // Cập nhật UI
  setState(() {});
}


  void _updateHotel(String hotelId) async {
  String? hotelImageURL;
  if (_hotelImageFile != null) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('hotels/${_hotelImageFile!.path.split('/').last}');
    await ref.putFile(_hotelImageFile!);
    hotelImageURL = await ref.getDownloadURL();
  }

  final hotelData = {
    'name': _nameController.text,
    'address': _addressController.text,
    'city': _cityController.text,
    'description': _descriptionController.text,
    'photos': hotelImageURL ?? _photosController.text, // Use new URL or existing string
    'toado': _toadoController.text,
     'price': int.tryParse(_priceController.text) ?? 0,
    'star': int.tryParse(_starController.text) ?? 0 ,
  };


    await _firestore.collection('Hotels').doc(hotelId).update(hotelData);

    _nameController.clear();
    _addressController.clear();
    _cityController.clear();
    _descriptionController.clear();
    _photosController.clear();
    _toadoController.clear();
    _hotelImageFile = null;
    _priceController.clear();
    _starController.clear();


    setState(() {});
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Danh sách khách sạn'),
      actions: [
        IconButton(
          onPressed: _showAddHotelDialog,
          icon: Icon(Icons.add),
        ),
      ],
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Hotels').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final hotels = snapshot.data!.docs;
          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotelData = hotels[index].data()! as Map<String, dynamic>;
              final hotelId = hotels[index].id;
              final imageUrl = hotelData['photos'];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(hotelData['name']),
                  subtitle: Text(hotelData['address']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteHotel(hotelId),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editHotel(hotelId),
                        ),
                      ],
                    ),

                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomsListPage(hotelId: hotelId),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Lỗi tải dữ liệu');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
