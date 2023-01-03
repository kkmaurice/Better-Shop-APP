// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shopapp/Models/products.dart';
import 'package:shopapp/Services/auth.dart';
import 'package:shopapp/Services/product_services.dart';
//import 'package:shopapp/Services/product_service.dart';

class ProductController with ChangeNotifier{

  final FirebaseService _service = FirebaseService();
  final _user = Auth().auth.currentUser;

   List<Product> _products = [];
   List<Product> _searchResult = [];

  List<Product> get products => _products;
  List<Product> get searchResult => _searchResult;


  void runFilter(String enteredKeyword) async{
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = _products;
    } else {
      results = _products.where((product) => product.title.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
      _searchResult = results;
      notifyListeners();
  }
  


  
  
  // toggle favorite status
  void toggleFavorite(Product prod) async{
    prod.isFavorite = ! prod.isFavorite;
    await _service.addProduct(prod);
    notifyListeners();
  }

  // get favorite products
  List<Product> get favoriteProducts{
    return _products.where((element) => element.isFavorite).toList();
  }

  // get products by category
  List<Product> getProductsByCategory(String category){
    return _products.where((element) => element.category.toLowerCase() == category.toLowerCase()).toList();
  }

  // Add product
  Future addToDb(context, String prodId, String title, String description, double oldPrice, double price, String category, String name, String location, int phone ,String imageUrl) async{
    if(prodId.isNotEmpty && title.isNotEmpty && description.isNotEmpty && price != null && imageUrl.isNotEmpty){
      await _service.addProduct(Product(
        userId: _user!.uid, 
        productId: prodId, 
        title: title, 
        description: description,
        oldPrice: oldPrice,  
        price: price, 
        imageUrl: imageUrl, 
        category: category, 
        location: location, 
        name: name, 
        phone: phone
        )
        );
    }else{
      showDialog(
        context: context, 
        builder: (context){
          return const AlertDialog(
            content: Text('Please check that all the fields are filled!'),
          );
        });
    }
    notifyListeners();
  }

  // fetch products
  Future<List<Product>> fetchProducts() async{
    var prod = await _service.getProduct();
    //print('${prod} ');
    if (prod is List<Product>){
      _products = prod;
    }
   //print(_products);
    notifyListeners();
    return _products;
  }
  


}