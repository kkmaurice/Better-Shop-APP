import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/auth.dart';
import 'password_reset.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.showLogin}) : super(key: key);

  VoidCallback showLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                   Text('Hello Again!',style: GoogleFonts.bebasNeue(fontSize: 52)),
                  const SizedBox(height: 50,),
                   Text('Welcome back, you\'ve been missed',style: GoogleFonts.courgette(fontSize: 20)),
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
                        borderSide: const BorderSide(color: Colors.white)
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
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return const PasswordRest();
                        })),
                        child: const Text('Forgot password?',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18))),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      if (_emailController.text.isNotEmpty || _passwordController.text.isNotEmpty){   
                       await Auth().signInUser(context, _emailController.text.trim(), _passwordController.text.trim());
                       
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)
                        ),
                      child: const Center(
                        child: Text('Sign In',style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?',style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: widget.showLogin,
                        child: const Text(' Register now',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)),
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