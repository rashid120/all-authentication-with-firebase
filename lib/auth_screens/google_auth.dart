import 'package:authentication/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({super.key});

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade300,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(height: double.infinity,child: Image.network('https://cdn.wallpapersafari.com/30/64/LCtajh.jpg', fit: BoxFit.cover,)),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 2,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade50, offset: const Offset(5, 5), blurRadius: 1),
                    const BoxShadow(color: Colors.white, offset: Offset(-5, -5), blurRadius: 20),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, size: 100, color: Colors.red.shade900,),
                    const Text('Google Authentication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 20,),
                    FilledButton(onPressed: (){

                      googleAuthentication();
                    },
                    style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red.shade900)
                    ),
                    child: const Text('Sign in with google'))
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }


  Future<void> googleAuthentication() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Initialize GoogleSignIn
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign in with Google
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount != null) {
        // Get the authentication details
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        // Get the OAuth credential
        OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken
        );

        // Sign in with the credential
        await auth.signInWithCredential(credential);

        // Navigate to the HomeScreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle any errors
      print("Error signing in with Google: $e");
    }
  }

}
