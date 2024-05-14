import 'package:authentication/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {

  bool remember = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ListTile(
                    leading: Icon(Icons.person, color: Colors.red.shade900, size: 40,),
                    title: const Text('Hello Dear 👋'),
                  ),
                  const SizedBox(height: 30,),
                  const Text('Nice to see you again', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),

                  const SizedBox(height: 20,),
                  const Text('Login'),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Enter Email",
                        border: InputBorder.none
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Password'),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: Icon(Icons.visibility),
                        border: InputBorder.none
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 10,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:Switch(value: remember, onChanged: (value) {
                      setState(() {remember = value;});
                    }, activeColor: Colors.red.shade900, inactiveTrackColor: Colors.grey.shade300,inactiveThumbColor: Colors.grey.shade400, trackOutlineColor: MaterialStateProperty.all(Colors.white)),
                    title: const Text('Remember me', style: TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,),
                    trailing: InkWell(child: const Text('Forgot password?', style: TextStyle(color: Colors.blueAccent, fontSize: 13),), onTap: (){},),
                  ),
                  
                  const SizedBox(height: 15,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(onPressed: () async{

                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

                      } on FirebaseAuthException catch(ex){
                        print(ex.message.toString());
                      }

                    }, style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    ), child: const Text('Sign in', style: TextStyle(color: Colors.white),)),
                  ),
              
                  const SizedBox(height: 25,),
                  const Divider(height: 1,),
                  const SizedBox(height: 10,),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ",),
                      InkWell(
                        onTap: (){},
                        child: const Text('Sign up now 👈', style: TextStyle(color: Colors.blueAccent)),
                      )
                    ],
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
