import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/core/constants/dismension_constants.dart';
import 'package:hotel_appv1/core/helpers/asset_helper.dart';
import 'package:hotel_appv1/core/helpers/image_helper.dart';
import 'package:hotel_appv1/representation/screen/hotel_booking_screen.dart';
import 'package:hotel_appv1/representation/widgets/app_bar_container.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/representation/widgets/item_hotel_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late String _username;

  Stream<QuerySnapshot>? _hotelsStream;

  void _getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _username = user.displayName ?? "Guest";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDisplayName();
    // Khởi tạo luồng khách sạn từ Firestore
    _hotelsStream = FirebaseFirestore.instance.collection('Hotels').snapshots();
  }

  Widget _builtItemCategory(
      Widget icon, Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: kMediumPadding,
            ),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kItemPadding)),
            child: icon,
          ),
          SizedBox(
            height: kItemPadding,
          ),
          Text(title)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Xin chào, $_username!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Nhập nơi bạn muốn đến',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kTopPadding),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: kDefaultPadding,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding),
              ),

              // Wrap TextField with GestureDetector:
              onTap: () {
                // Navigation to HotelBookingScreen
                Navigator.of(context).pushNamed(HotelBookingScreen.routeName);

                // Optional: Simulate Search (e.g., by changing the prefix icon)
                setState(() {
                  // Update UI elements here to indicate search action
                });
              },
            ),

            SizedBox(
              height: 15,
            ),
            // Sử dụng StreamBuilder để hiển thị khách sạn một cách năng động
            StreamBuilder<QuerySnapshot>(
              stream: _hotelsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: snapshot.data!.docs.map((hotelDoc) {
                      HotelModel hotelModel =
                          HotelModel.fromDocumentSnapshot(hotelDoc);
                      return ItemHotelWidget(hotelModel: hotelModel);
                    }).toList(),
                  );
                }
              },
            ),
            // Container(
            //   width: 160,
            //   height: 70,
            //   padding: EdgeInsets.only(bottom: 20),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(HotelBookingScreen.routeName);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: ColorPalette.primaryColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //     ),
            //     child: Text(
            //       'Tìm khách sạn',
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
