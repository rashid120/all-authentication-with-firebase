import 'package:authentication/auth_screens/email_login.dart';
import 'package:authentication/auth_screens/email_sign.dart';
import 'package:authentication/auth_screens/google_auth.dart';
import 'package:authentication/auth_screens/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
   const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List authScreens = [
    const PhoneAuth(),
    const GoogleAuth(),
    const EmailSingUp(),
    const EmailLogin()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,

        child: CarouselSlider.builder(
            slideBuilder: (index) {
              return authScreens[index];
            },
          unlimitedMode: true,
            itemCount: 4,
          slideIndicator: CircularSlideIndicator(
            currentIndicatorColor: Colors.green,
            indicatorBackgroundColor: Colors.white,
            indicatorBorderColor: Colors.grey,
            indicatorRadius: 5,
            padding: const EdgeInsets.only(bottom: 30)
          ),
          slideTransform: const CubeTransform(),
        ),
      ),
    );
  }
}
