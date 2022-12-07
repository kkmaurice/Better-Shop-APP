// ignore_for_file: sized_box_for_whitespace, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/cart_provider.dart';
import 'package:shopapp/Providers/product_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/products.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  static const routName = '/product_details';


  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      //backgroundColor: Colors.green,
      appBar: AppBar(
        toolbarHeight: 35,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          product.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                    right: 8,
                    top: 2,
                    left: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                              '-${(((product.oldPrice - product.price) / product.oldPrice) * 100).toStringAsFixed(1)}%'),
                          labelStyle: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<ProductController>()
                                  .toggleFavorite(product);
                            },
                            icon: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 40,
                              color:
                                  product.isFavorite ? Colors.red : Colors.white,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                product.description,
                style: GoogleFonts.roboto(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                'Ugx ${product.oldPrice}',
                style: GoogleFonts.dancingScript(
                    fontSize: 18,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ugx ${product.price}',
                style: GoogleFonts.dancingScript(fontSize: 18, color: Colors.red),
              ),
                    ],
                  ),
                  // section for a owners details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Seller\'s Details',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                      // name row
                      Row(
                        children: [
                          const Text('Name:'),
                          const SizedBox(width: 15,),
                          Text(product.name, style: const TextStyle(fontSize: 15),)
                        ],
                      ),
                      // location row
                      Row(
                        children: [
                          const Text('Location:'),
                          const SizedBox(width: 15,),
                          Text(product.location, style: const TextStyle(fontSize: 15),)
                        ],
                      ),
    
                      // contact raw
                      Row(
                        children: [
                          const Text('Phone:'),
                          const SizedBox(width: 15,),
                          Text('+256 ${product.phone}', style: const TextStyle(fontSize: 15),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Column(
                        children: [
                          
                          const SizedBox(width: 15,),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green
                            ),
                            child: IconButton(
                              onPressed: () async{
                                final Uri launchUri = Uri(
                                       scheme: 'tel',
                                       path: product.phone.toString(),
                                      );
                                  await launchUrl(launchUri);
                              }, 
                              icon: const Icon(Icons.phone)),
                          ),
                          const Text('Call'),
                        ],
                      ),
                      const SizedBox(width: 50,),
                      // sms raw
                      Column(
                        children: [
                         const SizedBox(width: 15,),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue
                            ),
                            child: IconButton(
                              onPressed: () async{
                                final Uri launchUri = Uri(
                                       scheme: 'sms',
                                       path: product.phone.toString(),
                                      );
                                  await launchUrl(launchUri);
                              }, 
                              icon: const Icon(Icons.send)),
                          ),
                          const Text('SMS'),
                        ],
                      )
                        ],
                      )
                      //Text(product.name),
                      // Text('+256 ${product.phone}', style: TextStyle(color: Colors.black),),
                      // Icon(Icons.person)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.roboto(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Ugx ${product.price}',
                          style: GoogleFonts.dancingScript(
                              fontSize: 18, color: Colors.red))
                    ],
                  ),
                  context.watch<CartProvider>()
                          .cart.contains(product.productId)
                      ? Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.height * 0.32,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'Already in Cart',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 18),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                             context.read<CartProvider>().addCart(product.productId, product.userId, product.title, product.imageUrl, product.price);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 100,
                                  right: 20,
                                  left: 20),
                              content: Text('${product.title} added to cart'),
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () => context
                                      .read<CartProvider>()
                                      .deleteItem(product.productId)),
                            ));
                          },
                          child: context.watch<CartProvider>().isLoading? const Center(child: CircularProgressIndicator(),) : Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.height * 0.32,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.kanit(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
