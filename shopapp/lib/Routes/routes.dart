

import 'package:flutter/material.dart';
import 'package:shopapp/Auth/auth_screens/main_page.dart';
import 'package:shopapp/Screens/home_screen.dart';
import 'package:shopapp/Screens/input_screen.dart';
import 'package:shopapp/Screens/payment_page.dart';
import 'package:shopapp/Screens/product_details.dart';

class RoutesManager{
  static const mainPage = '/';
  static const homeScreen = '/home_screen';
  static const productInputScreen = '/product_input_screen';
  static const productDetailsScreen = '/product_details';
  static const orderDetailsScreen = '/order_details';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case mainPage:
      return MaterialPageRoute(
        builder: (context) => const MainPage()
        );
      case homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
      case productInputScreen:
      return MaterialPageRoute(builder: (context) => const ProductInputScreen());
      case productDetailsScreen:
      return MaterialPageRoute(builder: (context) => const ProductDetails());
      case orderDetailsScreen:
      return MaterialPageRoute(builder: (context) => const OrderDetails());

      default:
           throw const FormatException('Route not found! check route again');  

    }
  }
}