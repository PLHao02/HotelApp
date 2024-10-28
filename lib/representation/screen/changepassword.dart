import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/representation/screen/main_app.dart';
import 'package:hotel_appv1/representation/screen/profilepage.dart';
import 'package:hotel_appv1/toast.dart';
import 'package:toast/toast.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  void _changePassword() async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    if (newPassword != confirmNewPassword) {
        showToast(message: "Mật khẩu mới không trùng nhau");
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Tạo một đối tượng thông tin đăng nhập bằng email và mật khẩu hiện tại của người dùng
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);

        // Reauthenticate user
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);

        showToast(message: "Mật khẩu được thay đổi thành công");
      } else {
        showToast(message: "Không thể thay đổi mật khẩu, vui lòng đăng nhập lại");
      }
    } catch (error) {
      showToast(message: "Đã xảy ra lỗi khi thay đổi mật khẩu");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Thay đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPasswordTextField(_currentPasswordController, Icons.lock, 'Mật khẩu hiện tại'),
            SizedBox(height: 20),
            buildPasswordTextField(_newPasswordController, Icons.lock_outline, 'Mật khẩu mới'),
            SizedBox(height: 20),
            buildPasswordTextField(_confirmNewPasswordController, Icons.lock_outline, 'Xác nhận mật khẩu mới'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Thay đổi mật khẩu'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainApp()),
                (route) => false,
              );
            },
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(Icons.arrow_left, color: Colors.white),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Đặt vị trí của FAB ở góc phải dưới
    );
  }

  Widget buildPasswordTextField(TextEditingController controller, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(icon,
            color: Colors.black,),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: label,
                ),
                obscureText: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
