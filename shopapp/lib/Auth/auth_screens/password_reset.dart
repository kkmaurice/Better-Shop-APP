
import 'package:flutter/material.dart';

import '../../Services/auth.dart';

class PasswordRest extends StatefulWidget {
  const PasswordRest({Key? key}) : super(key: key);

  @override
  State<PasswordRest> createState() => _PasswordRestState();
}

class _PasswordRestState extends State<PasswordRest> {
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please provide your email below and we will send you a password reset link',style: TextStyle(fontSize: 17),),
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
                      GestureDetector(
                        onTap: () async{
                          await Auth().passwordReset(context, _emailController.text.trim());
                          _emailController.text = '';
                        },
                        child: Container(
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15)
                              ),
                            child: const Center(
                              child: Text('Reset password',style: TextStyle(color: Colors.white, fontSize: 18),),
                            ),
                          ),
                      ),
                      
            ],
          ),
        ),
      ),
    );
  }
}