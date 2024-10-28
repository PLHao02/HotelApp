import 'package:flutter/material.dart';

class PhoneNumberInputScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  static const String routeName = '/PhoneNumberInput_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nhập Số Điện Thoại')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Nhập số điện thoại',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newPhoneNumber = _phoneController.text;
                Navigator.pop(context, newPhoneNumber);
              },
              child: Text('Lưu Số Điện Thoại'),
            ),
          ],
        ),
      ),
    );
  }
}
