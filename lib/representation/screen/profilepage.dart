import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/representation/screen/changepassword.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/representation/widgets/avatar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Stack(
      children: [
        Positioned.fill(
          child: AppBarContainerWidget(
            titleString: 'Thông tin cá nhân',
            //padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(),
                // SizedBox(height: 10), 
                _buildUserInfoRow(
                  icon: Icons.person,
                  label: 'Tên người dùng:',
                  value: user?.displayName ?? 'N/A',
                ),
                SizedBox(height: 10), 
                _buildUserInfoRow(
                  icon: Icons.email,
                  label: 'Email:',
                  value: user?.email ?? 'N/A',
                ),
                SizedBox(height: 20), 
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 90.0,
          child: FloatingActionButton(
                heroTag: "btn1",
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                (route) => false,
              );
            },
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(Icons.lock, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
                heroTag: "btn2",
            onPressed: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(Icons.logout, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white70),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
