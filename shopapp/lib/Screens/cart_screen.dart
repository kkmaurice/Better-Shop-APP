// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/cart_provider.dart';
import 'package:shopapp/Providers/orders.dart';
import 'package:shopapp/Screens/payment_page.dart';
import 'package:shopapp/Models/cart.dart' as tp;

import '../Services/auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    final cartTotal = context.watch<CartProvider>();
    final CollectionReference _ref =
        FirebaseFirestore.instance.collection('cart');
    // get the index of the item to send
    final index = cart.indexWhere((element) => element.cartId == element.cartId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: GoogleFonts.openSans(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: context.read<CartProvider>().fetchCartItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<CartProvider>().clearCart();
                          },
                          child: const Chip(
                            label: Text(
                              'Clear Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        ),
                        Row(
                          children: [
                            // total chip
                            Chip(
                              label: Text(
                                'Ugx. ${context.watch<CartProvider>().totalAmount.toStringAsFixed(1)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // order chip
                            cart.isNotEmpty
                                ? GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await context
                                          .read<OrderProvider>()
                                          .addToCart(
                                              cart, cartTotal.totalAmount);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      // clear cart logic
                                      await context
                                          .read<CartProvider>()
                                          .clearCart();
                                      // after, navigate to order details page
                                      Navigator.of(context).pushNamed(
                                          OrderDetails.routName,
                                          arguments: cart[index]
                                          );
                                    },
                                    child: _isLoading
                                        ? const Center(
                                            child: SizedBox(
                                                height: 25,
                                                width: 25,
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : const Chip(
                                            label: Text(
                                              'Order',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.black,
                                          ),
                                  )
                                : const Chip(
                                    label: Text(
                                      'Order',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black38,
                                  ),
                          ],
                        )
                      ],
                    ),
                    cart.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  return 
                                      CartItem(
                                        id: cart[index].cartId,
                                        title: cart[index].title,
                                        imageUrl: cart[index].imageUrl,
                                        price: cart[index].price,
                                        quantity: cart[index].quantity);
                                        
                                    
                                }),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Your Cart is Empty!!',
                                    style: TextStyle(fontSize: 35),
                                  )),
                              Container(
                                  child: Text('Add Something to Your cart')),
                            ],
                          ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      //key: UniqueKey(),
      key: Key(id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 35,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartProvider>().deleteItem(id);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Do you want to delete?'),
                  content:
                      const Text('Click Confirm to delete or Undo to undo'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Chip(
                            label: Text(
                              'Undo',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop(true);
                          },
                          child: const Chip(
                            label: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                ));
      },
      child: Column(
        children: [
        Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 0,
          color: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.notoSerif(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ugx ${price * quantity}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '< < < swipe left to delete',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[50],
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            var user = Auth().auth.currentUser!.uid;
                            context.read<CartProvider>().incrementCartItem(
                                id, user, title, imageUrl, price);
                          },
                          icon: const Icon(Icons.add_circle)),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () {
                            var user = Auth().auth.currentUser!.uid;
                            context.read<CartProvider>().decrementCartItem(
                                id, user, title, imageUrl, price);
                          },
                          icon: const Icon(Icons.remove_circle))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
  
      ]
      ),
    );
  }
}
