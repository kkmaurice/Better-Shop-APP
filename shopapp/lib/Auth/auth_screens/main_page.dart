import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopapp/Screens/home_screen.dart';
import 'package:shopapp/Services/auth.dart';

import 'auth_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return const HomeScreen();
          }else{
            return const AuthPage();
          }
        },
      ),
    );
  }
}