// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel_appv1/core/constants/color_constants.dart';
import 'package:hotel_appv1/data/models/firebase.dart';
import 'package:hotel_appv1/representation/admin/addhotelpage.dart';
import 'package:hotel_appv1/representation/admin/admin_page.dart';
import 'package:hotel_appv1/representation/screen/forgot_password_page.dart';
import 'package:hotel_appv1/representation/screen/home_screen.dart';
import 'package:hotel_appv1/representation/screen/intro_screen.dart';
import 'package:hotel_appv1/representation/screen/login_page.dart';
import 'package:hotel_appv1/representation/screen/main_app.dart';
import 'package:hotel_appv1/representation/screen/sign_up_page.dart';
import 'package:hotel_appv1/representation/screen/splash_screen.dart';
import 'package:hotel_appv1/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDbWnKScqeslprEaAd9q2HqczNpjGt0yOE",
        appId: "1:522823910434:android:99eec52afe868c021b367b",
        messagingSenderId: "522823910434",
        projectId: "khachsan-9cbe6",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const HotelApp());
  // await createHotelsAndRooms();
}

class HotelApp extends StatelessWidget {
  const HotelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primaryColor: Color(0xFFDFE0E4),
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
        backgroundColor: ColorPalette.backgroundScaffoldColor,
      ),
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        //  '/create-room': (context) => CreateRoomScreen(), // Đảm bảo route này được định nghĩa
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => MainApp(),
        '/intro': (context) => IntroScreen(),
        '/admin': (context) => AdminPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
        ...routes,
      },
      onGenerateRoute: generateRoutes,
    );
  }
}
