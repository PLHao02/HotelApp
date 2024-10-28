import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/representation/admin/XemDSDonDaDat.dart';
import 'package:hotel_appv1/representation/admin/XemDSKhachSan.dart';
import 'package:hotel_appv1/representation/admin/addhotelpage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AdminPage extends StatefulWidget{
  const AdminPage({Key?key}):super(key: key);
  @override
  State<AdminPage> createState() => _AdminPageState();
  
}

class _AdminPageState extends State<AdminPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HotelsListPage(),
          XemDSDonDatDat(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
        margin: EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: kDefaultIconSize,
            ),
            title: Text('Danh sách khách sạn'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.briefcase,
              size: kDefaultIconSize,
            ),
            title: Text('Các đơn đã đặt'),
          ),
        ],
      ),
    );
  }
}