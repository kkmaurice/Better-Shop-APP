import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Screens/cart_screen.dart';
import 'package:shopapp/Screens/favorite_screen.dart';
import 'package:shopapp/Screens/order_screen.dart';
import 'package:shopapp/Screens/product_overviewScreen.dart';

import '../Providers/cart_provider.dart';
import '../Widgets/badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Color _color = Colors.redAccent;
  Color _colorNormal = Colors.grey;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    ProductOverView(),
    CartScreen(),
    OrderScreen(),
    FavoriteProducts()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          //alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(top: 5),
          height: 53,
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.9),
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _onItemTapped(0);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      Icon(Icons.home_outlined,
                          color: _selectedIndex == 0 ? _color : _colorNormal),
                      Expanded(
                          child: Text(
                        'Home',
                        style: TextStyle(
                            color: _selectedIndex == 0 ? _color : _colorNormal),
                      ))
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future: context.watch<CartProvider>().fetchCartItems(),
                  builder: ((context, snapshot) {
                    return Container(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Badge(
                              value: context
                                  .watch<CartProvider>()
                                  .itemCount
                                  .toString(),
                              color: Colors.red,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                child: IconButton(
                                    onPressed: () {
                                      _onItemTapped(1);
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 35,
                                      color: _selectedIndex == 1
                                          ? _color
                                          : _colorNormal,
                                    )),
                              )),
                        ],
                      ),
                    );
                  })),
              GestureDetector(
                onTap: () {
                  _onItemTapped(2);
                },
                child: Container(
                  //padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          color: _selectedIndex == 2 ? _color : _colorNormal),
                      Expanded(
                          child: Text(
                        'Orders',
                        style: TextStyle(
                            color: _selectedIndex == 2 ? _color : _colorNormal),
                      ))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onItemTapped(3);
                },
                child: Container(
                  //padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      Icon(Icons.favorite_outlined,
                          color: _selectedIndex == 3 ? _color : _colorNormal),
                      Expanded(
                          child: Text(
                        'Favorites',
                        style: TextStyle(
                            color: _selectedIndex == 3 ? _color : _colorNormal),
                      ))
                    ],
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
