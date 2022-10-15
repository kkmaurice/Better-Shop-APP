import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Auth/auth_screens/main_page.dart';
import 'package:shopapp/Providers/cart_provider.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:shopapp/Routes/routes.dart';
import 'package:shopapp/Screens/payment_page.dart';
import 'package:shopapp/Screens/product_details.dart';

import 'Providers/orders.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isWindows ? DefaultFirebaseOptions.web : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        //home: const MainPage(),

        initialRoute: RoutesManager.mainPage,
        onGenerateRoute: RoutesManager.generateRoute,

        routes: {
          '/': (context) => const MainPage(),
          ProductDetails.routName: (context) => const ProductDetails(),
          OrderDetails.routName:(context) => const OrderDetails()
        },
      ),
    );
  }
}
