import 'package:authentication/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key, required this.verificationId});

  final String verificationId;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verification Code', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900, fontSize: 20),),
            const SizedBox(height: 15,),
            const Text('We have sent the verification code to your phone number'),
            const SizedBox(height: 30,),
            // for otp
            buildOTPDigitsRow(),
            const SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (){

                  String otp = getEnteredOtp();
                  if (kDebugMode) {
                    print(otp);
                  }
                  if(otp.length >= 5) {
                    PhoneAuthCredential credential = PhoneAuthProvider
                        .credential(
                        verificationId: widget.verificationId, smsCode: otp);
                    FirebaseAuth.instance.signInWithCredential(credential).then((value) => {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
                    });
                  }

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25))),
                ),
                child: const Text('Confirm', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOTPDigitsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          6,
          (index) => SizedBox(
          width: 40,
          height: 40,
          child: TextField(
            controller: otpControllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: '0',
              counterText: '',
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getEnteredOtp(){
    String otp = '';
    for(TextEditingController controller in otpControllers){
      otp += controller.text;
    }
    return otp;
  }
}
