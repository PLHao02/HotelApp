import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsListPage extends StatefulWidget {
  final String hotelId;

  const RoomsListPage({Key? key, required this.hotelId}) : super(key: key);

  @override
  _RoomsListPageState createState() => _RoomsListPageState();
}

class _RoomsListPageState extends State<RoomsListPage> {
  final _firestore = FirebaseFirestore.instance;

  // Controllers for the new room form
  final _roomTypeController = TextEditingController();
  final _priceController = TextEditingController();
  final _photosController = TextEditingController(); // For a list of image URLs
  final _descriptionController = TextEditingController(); // For the description

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phòng'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Rooms')
            .where('hotelId', isEqualTo: widget.hotelId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final rooms = snapshot.data!.docs;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final roomData = rooms[index].data()! as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(roomData['photos'][0]),
                    title: Text(roomData['roomType']),
                    subtitle: Text(
                        'Giá: ${roomData['price']}\nMô tả: ${roomData['description']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Keep buttons close
                      children: [
                        IconButton(
                          onPressed: () => _showEditRoomDialog(rooms[index]),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => _deleteRoom(rooms[index].id),
                          icon: Icon(Icons.delete),
                        ),
                      ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRoomDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thêm Phòng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _roomTypeController,
              decoration: InputDecoration(hintText: 'Loại phòng'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Giá'),
            ),
            TextField(
              controller: _photosController,
              decoration: InputDecoration(
                  hintText: 'Ảnh (URLs cách nhau bởi dấu phẩy)'),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 3, // Adjust as needed for description length
              decoration: InputDecoration(hintText: 'Mô tả'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () => _addRoom(),
            child: Text('Thêm'),
          ),
        ],
      ),
    );
  }
  void _addRoom() {
    String roomType = _roomTypeController.text;
    double price = double.parse(_priceController.text);
    List<String> photos = _photosController.text.split(',');
    String description = _descriptionController.text;

    _firestore.collection('Rooms').add({
      'hotelId': widget.hotelId,
      'roomType': roomType,
      'price': price,
      'photos': photos,
      'description': description,
    }).then((_) {
      Navigator.of(context).pop();
      _roomTypeController.clear();
      _priceController.clear();
      _photosController.clear();
      _descriptionController.clear();
    });
  }
  void _showEditRoomDialog(QueryDocumentSnapshot roomDoc) {
    // Pre-fill controllers with existing data
    _roomTypeController.text = roomDoc['roomType'];
    _priceController.text = roomDoc['price'].toString();
    _photosController.text = roomDoc['photos'].join(',');
    _descriptionController.text = roomDoc['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sửa phòng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _roomTypeController,
              decoration: InputDecoration(hintText: 'Loại phòng'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Giá'),
            ),
            TextField(
              controller: _photosController,
              decoration: InputDecoration(
                  hintText: 'Ảnh (URLs cách nhau bởi dấu phẩy)'),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 3, 
              decoration: InputDecoration(hintText: 'Mô tả'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () => _updateRoom(roomDoc.id),
            child: Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  void _updateRoom(String roomId) {
    String roomType = _roomTypeController.text;
    double price = double.parse(_priceController.text);
    List<String> photos = _photosController.text.split(',');
    String description = _descriptionController.text;

    _firestore.collection('Rooms').doc(roomId).update({
      'roomType': roomType,
      'price': price,
      'photos': photos,
      'description': description,
    }).then((_) {
      Navigator.of(context).pop();
      _roomTypeController.clear();
      _priceController.clear();
      _photosController.clear();
      _descriptionController.clear();
    });
  }

  Future<void> _deleteRoom(String roomId) async {
    await _firestore.collection('Rooms').doc(roomId).delete();
  }
}