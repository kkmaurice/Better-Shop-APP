import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Auth{

  FirebaseAuth auth = FirebaseAuth.instance;

  Future createNewUser(String email, String password) async{
      return await  auth.createUserWithEmailAndPassword(email: email, password: password);
  }


  Future signInUser(BuildContext context, String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      return showDialog(
        context: context, 
        builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  Future passwordReset(BuildContext context, String email) async{
    try{
      await auth.sendPasswordResetEmail(email: email);
      showDialog(context: context, 
      builder: (context){
        return const AlertDialog(
          content: Text('password reset sent! check your email'),
        );
      });
    } on FirebaseException catch(e){
      showDialog(context: context, 
      builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  void logOut() async{
    await auth.signOut();
  }
}