import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/cart_provider.dart';
import 'package:shopapp/Providers/dark_theme.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:shopapp/Routes/routes.dart';
import 'package:shopapp/Screens/google_map_screen.dart';
import 'package:shopapp/Services/dark_theme_prefs.dart';
import 'package:shopapp/consts/theme_data.dart';

import 'Auth/auth_screens/main_page.dart';
import 'Providers/orders.dart';
import 'Screens/cart_screen.dart';
import 'Screens/order_screen.dart';
import 'Screens/product_details.dart';
import 'firebase_options.dart';

void main() async {
  //lock device orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: Platform.isWindows ? DefaultFirebaseOptions.web : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getDarkTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => DarkThemeProvider())
      ],
      builder: ((context, child) {
        return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(context.watch<DarkThemeProvider>().getDarkTheme, context),
        //home: const MainPage(),
        initialRoute: MainPage.routeName,
        onGenerateRoute: RoutesManager.generateRoute,
       
        routes: {
          MainPage.routeName: (context) => const MainPage(),
          ProductDetails.routName: (context) => const ProductDetails(),
          GoogleMapsPage.routeName: (context) => const GoogleMapsPage(),
          
        },
      );
      }) ,
    );
  }
}
