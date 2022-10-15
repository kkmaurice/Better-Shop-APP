import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopapp/Auth/auth_screens/login_page.dart';
import 'package:shopapp/Auth/auth_screens/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginScreen = true;

  void toggleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (showLoginScreen){
      return LoginPage(showLogin: toggleScreens);
    }else{
      return SignUp(signUpScreen: toggleScreens);
    }
  }
}