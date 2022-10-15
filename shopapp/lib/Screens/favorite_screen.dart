import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Screens/product_details.dart';

import '../Providers/product_controller.dart';

class FavoriteProducts extends StatelessWidget {
  const FavoriteProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = Provider.of<ProductController>(context).favoriteProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return 
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetails.routName, arguments: favoriteProducts[index]);
            },
            child: Card(
              margin: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      favoriteProducts[index].imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(child: Text(favoriteProducts[index].title,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
                  Text('\Ugx. ${favoriteProducts[index].price.toString()}',style: const TextStyle(fontSize: 17,),),
                ],
              )
            ),
          );
        })
    );
  }
}