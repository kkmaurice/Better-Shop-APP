import 'package:flutter/material.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Models/cart.dart' as tip;

import '../Providers/cart_provider.dart';

//import 'package:shopapp/Screens/cart_screen.dart' as tip;



class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  static const routName = '/order_details';

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  //use the currency you would like the user to Pay In, in this case, I used KES currency
  final String currency = FlutterwaveCurrency.UGX;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final orders = ModalRoute.of(context)!.settings.arguments as tip.CartItem;
    
   final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back,color: Colors.green,)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title:  const Text(
          'Flutter + Flutterwave',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
       child: Form(
            key: formKey,
         child:Column(
          children: [
          const Padding(padding: EdgeInsets.all(10.0)),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: fullname,
              decoration: const InputDecoration(labelText: "Full Name"),
                   validator: (value) =>
                      value!.isNotEmpty? null : "Please fill in Your Name",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
               validator: (value) =>
                      value!.isNotEmpty? null : "Please fill in Your Phone number",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                      value!.isNotEmpty? null : "Please fill in Your Email",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: amount,
              decoration: const InputDecoration(labelText: "Amount"),
              validator: (value) =>
                      value!.isNotEmpty? null : "Please fill in the Amount you are Paying",
                ),
          ),
          ElevatedButton(
            child: const Text('Pay with Flutterwave'),
            onPressed: () {

            },
          ),
        ])))
    );
  }
}