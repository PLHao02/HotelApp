import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  File? _avatarFile;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveAvatar() async {
    if (_avatarFile != null) {
      try {
        await _currentUser!.updateProfile(photoURL: _avatarFile!.path);
        setState(() {
          _avatarFile = null;
        });
      } catch (e) {
        print('Lỗi lưu avatar: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _avatarFile != null
            ? Image.file(_avatarFile!, width: 100, height: 100)
            : _currentUser!.photoURL != null
                ? CircleAvatar(
                    radius: 50,

                    backgroundImage: NetworkImage(_currentUser!.photoURL!),
                  )
                : const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
        const SizedBox(height:15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: _pickImage,
            //   child: const Text('Chọn ảnh'),
            // ),
            // const SizedBox(width: 20),
            // ElevatedButton(
            //   onPressed: _saveAvatar,
            //   child: const Text('Lưu'),
            // ),
          ],
        ),
      ],
    );
  }
}
