import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, required this.signUpScreen}) : super(key: key);

  VoidCallback signUpScreen;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

   TextEditingController _emailController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();
   TextEditingController _confirmPasswordController = TextEditingController();

   bool _isloading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Image.asset('assets/login.png',height: 120,width: 120,),
                   Text('Hello There',style: GoogleFonts.bebasNeue(fontSize: 52)),
                  const SizedBox(height: 50,),
                   Text('Register below with your details',style: GoogleFonts.courgette(textStyle: const TextStyle(fontSize: 20))),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple
                        )
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    ),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple
                        )
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    ),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple
                        )
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    ),
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty){
                        if (_passwordController.text == _confirmPasswordController.text){
                          if(_isloading){
                            const Center(child: CircularProgressIndicator(),);
                          }
                         await Auth().createNewUser(_emailController.text.trim(), _passwordController.text.trim());
                         _isloading = false;
                        } else {
                          showDialog(
                            context: context, 
                            builder: (context){
                              return const AlertDialog(
                                content: Text('Passwords are not matching, please check that you have the same passwords'),
                              );
                            });
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)
                        ),
                      child: const Center(
                        child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('I am a member',style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: widget.signUpScreen,
                        child: const Text(' Login now',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)),
                    ],
                  )    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}