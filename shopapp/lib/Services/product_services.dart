// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/Models/products.dart';

class FirebaseService{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('product');

// add products to firebase
  Future addProduct(Product prod) async{
    await _ref
          .doc(prod.productId)
          .set(prod.toMap(), SetOptions(merge: true));
  }

// get products from the firebase
  Future getProduct() async{
    try{
      var myDocuments = await  _ref.get();
    if (myDocuments.docs.isNotEmpty){
      return myDocuments
              .docs
              .map((snapshot) => 
              Product.fromMap(snapshot.data() as Map<String, dynamic>)).toList();
    }
    } catch(e){
      if( e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }

  //filter products by search keyword
  //  Future<List<Product>> searchProducts(String productName) async {
  //   // code to convert the first character to uppercase
  //   String searchKey = productName[0].toUpperCase() + productName.substring(1);
  //   return await _ref
  //       .where("title", isGreaterThanOrEqualTo: searchKey)
  //       .orderBy("title")
  //       .startAt([searchKey])
  //       .endAt(['$searchKey\uf8ff'])
  //       .get()
  //       .then((result) {
  //     List<Product> products = [];
  //     for (DocumentSnapshot product in result.docs) {
  //       products.add(Product.fromMap(product as Map<String, dynamic>));
  //     }
  //     return products;
  //   });
  // }


}