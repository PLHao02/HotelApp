//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:hotel_appv1/data/models/hotel_model.dart';
import 'package:hotel_appv1/data/models/room_model.dart';
import 'package:hotel_appv1/representation/screen/PhoneNumberInputScreen.dart';
import 'package:hotel_appv1/representation/screen/select_city_screen.dart';
import 'package:hotel_appv1/representation/screen/checkout_screen.dart';
import 'package:hotel_appv1/representation/screen/donescreen.dart';
import 'package:hotel_appv1/representation/screen/guest_and_room_booking_screen.dart';
import 'package:hotel_appv1/representation/screen/hotel_booking_screen.dart';
import 'package:hotel_appv1/representation/screen/hotel_detail_screen.dart';
import 'package:hotel_appv1/representation/screen/hotels_screen.dart';
import 'package:hotel_appv1/representation/screen/intro_screen.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/screen/main_app.dart';
import 'package:hotel_appv1/representation/screen/select_date_screen.dart';
import 'package:hotel_appv1/representation/screen/select_room_screen.dart';
//import 'package:hotel_appv1/representa-tion/screen/splash_screen.dart';
import 'package:hotel_appv1/representation/screen/payment.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  GuestAndRoomBookingScreen.routeName: (context) => GuestAndRoomBookingScreen(),
  // HotelsScreen.routeName: (context) => HotelsScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  select_city_screen.routeName: (context) => select_city_screen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  PhoneNumberInputScreen.routeName: (context) => PhoneNumberInputScreen(),
  DoneScreen.routeName: (context) {
    // Lấy đối số được truyền vào route này
    final args = ModalRoute.of(context)!.settings.arguments;

    // Đảm bảo rằng đối số truyền vào là kiểu Map<String, dynamic>
    if (args is Map<String, dynamic>) {
      // Trích xuất các thông tin từ đối số
      final int paymentMethod = args['paymentMethod'] as int;
      final RoomModel roomModel = args['roomModel'] as RoomModel;

      // Trả về DoneScreen với các thông tin đã trích xuất
      return DoneScreen(
        paymentMethod: paymentMethod,
        roomModel: roomModel,
      );
    } else {
      // Xử lý fallback nếu đối số không hợp lệ
      return Scaffold(
        body: Center(
          child: Text('Tham số không hợp lệ cho DoneScreen'),
        ),
      );
    }
  },
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HotelDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          final HotelModel hotelModel = (settings.arguments as HotelModel);
          return HotelDetailScreen(
            hotelModel: hotelModel,
          );
        },
      );
    case CheckoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          final RoomModel roomModel = (settings.arguments as RoomModel);
          return CheckoutScreen(
            roomModel: roomModel,
          );
        },
      );
    default:
      return null;
  }
  //return null;
}
