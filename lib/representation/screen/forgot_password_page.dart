import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/screen/sign_up_page.dart';
import 'package:hotel_appv1/representation/widgets/form_container_widget.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password reset email sent to $email"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your email"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              SizedBox(
                height: 100,
              ),
            SizedBox(
                width: 200, // specify your desired width
                height: 200, // specify your desired height
                child: Lottie.network(
                  'https://lottie.host/91b9e995-cc58-4a3d-a26f-a52a70487f22/x8EcvsMYyy.json',
                ),
              ),
              Text(
                "Nhập email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
               SizedBox(
                height: 10,
              ),
            FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text(
                "Reset Password",
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryColor, // Set button color to red
              ),
            ),
              SizedBox(
                height: 5,
              ),
           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        color: ColorPalette.secondColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
