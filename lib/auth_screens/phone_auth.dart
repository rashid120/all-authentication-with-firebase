
import 'package:authentication/auth_screens/opt_varification.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {

  TextEditingController phoneController = TextEditingController();

  String? currentCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Expanded(
              child: Center(child: Image.network('https://th.bing.com/th/id/OIP.9QHGBKU0ttqAO4x1ZpIHuAHaHa?rs=1&pid=ImgDetMain', width: 200, height: 200,))
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [

                    Text('REGISTRATION', style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.bold, fontSize: 17),),
                    const SizedBox(height: 15,),
                    const Text('Please confirm your country code and \nenter your phone number', textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),

                    const SizedBox(height: 30,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: TextField(
                        controller: phoneController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: 'Enter number',
                          border: InputBorder.none,
                          counterText: '',
                          prefixIcon: TextButton(

                            onPressed: () =>
                                showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height / 6,
                                    child: picCountryCode(context),
                                  );
                                }
                            ),
                            child: Text('$currentCountryCode'),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){

                          if(phoneController.text.isNotEmpty) {
                            showAlertDialog();
                          }else{
                            print("Please enter phone number");
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        child: const Text('Confirm and Continue', style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }

  Widget picCountryCode(BuildContext context){

    return CountryCodePicker(

      initialSelection: 'IN',
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      favorite: const ['IN','PS','AF', 'IR'],
      onChanged: (CountryCode countryCode) {
        setState(() {
          currentCountryCode = countryCode.dialCode.toString();
        });
        Navigator.pop(context);
      },

    );
  }

  showAlertDialog(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Center(child: Text('Alert')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 3, color: Colors.grey,),
          const SizedBox(height: 10,),
          Icon(Icons.warning, color: Colors.red.shade900, size: 50,),
          const SizedBox(height: 20,),
          Text("Make sure ($currentCountryCode${phoneController.text}) is your real number.", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          const Text('We will request number verification later to use our app features.', textAlign: TextAlign.center),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                },style:  ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)))),
                  backgroundColor: MaterialStateProperty.all(Colors.grey.shade700)
                ), child: const Text('  Edit ', style: TextStyle(color: Colors.white),)),
              ),
              const SizedBox(width: 1,),
              SizedBox(
                height: 45,
                child: ElevatedButton(onPressed: () async{

                  FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: currentCountryCode!+phoneController.text,
                      verificationCompleted: (PhoneAuthCredential credential){},
                      verificationFailed: (FirebaseAuthException ex){},
                      codeSent: (String verificationId, int? code){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerification(verificationId: verificationId,)));
                      },
                      codeAutoRetrievalTimeout: (String timeOut){}
                  );
                },
                  style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)))),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade900),
                ), child: const Text('Confirm', style: TextStyle(color: Colors.white),)),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
