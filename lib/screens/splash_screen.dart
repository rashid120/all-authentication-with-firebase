
import 'package:authentication/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()),);
            });
          }else{

            Future.delayed(Duration.zero, (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
            });
          }
          // Return an empty container if there's no data (user not logged in yet)
          return Container();
        },
      ),
    );
  }
}
