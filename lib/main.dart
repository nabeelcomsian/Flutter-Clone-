import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Responsive/mobile_screen_layout.dart';
import 'package:instagram/Responsive/responsive_layout_screen.dart';
import 'package:instagram/Responsive/web_screen_layout.dart';
import 'package:instagram/Screens/login_screen.dart';
import 'package:instagram/Screens/signup_screen.dart';
import 'package:instagram/Utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is initialized before running
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCRv8xCvNfTRd4B9jPR_JbOEC4YEq7sGYY',
          appId: '1:810871263111:web:f586b7e8e4048e06028d22',
          messagingSenderId: '810871263111',
          projectId: 'flutter-clone-c2281'),
    );
  } else {
    debugPrint('in else section ');
    await Firebase.initializeApp();
    debugPrint('flutter initialize');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayoutScreen(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const SignupScreen(),
    );
  }
}
