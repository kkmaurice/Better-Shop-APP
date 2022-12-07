
import 'package:flutter/cupertino.dart';
import 'package:shopapp/Models/cart.dart';

import '../Services/cart_service.dart';

class CartProvider with ChangeNotifier{

  final CartService _service = CartService();
 
  // map to store out cart items
  List<CartItem> _carts = [];
  bool _isLoading = false;
  
 
  List<CartItem> get cart => _carts;
  bool get isLoading => _isLoading;

  // get the length of cart
  int get itemCount => _carts.length;


  double get totalAmount {
    double total = 0.0;
    _carts.forEach((cartItem) { 
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }


  // add to cart
  Future addCart(String productId, String userId, String title, String imageUrl, double price) async{

    final index1 = _carts.indexWhere((element) => element.cartId == productId);
     if (index1 != -1){
      var myCart = _carts[index1].quantity += 1;
     
     _service.addCart(CartItem(userId: userId, cartId: productId, title: title, imageUrl: imageUrl, quantity: myCart, price: price));

     print('llllllllllllllll ${ _carts[index1].quantity}');
     }
    else{
       //_isLoading = true;
     await _service.addCart(CartItem(userId: userId, cartId: productId, title: title, imageUrl: imageUrl, quantity: 1, price: price));
      // _isLoading = false;
    }
    notifyListeners();
  }
  
  // fetch cartItems
  Future<List<CartItem>> fetchCartItems() async{
    var cartItem = await _service.getCart();
    //print(cartItem);
    if (cartItem != null){
      _carts = cartItem as List<CartItem>;
    }
   //print(_carts.length);
    notifyListeners();
    return _carts;
  }

  // increment quantity of a specific cart item
    
  Future incrementCartItem(String id, String userId, String title, String imageUrl, double price) async{
    final index1 = _carts.indexWhere((element) => element.cartId == id);
  var cartIncr = _carts[index1].quantity += 1;
  _service.addCart(CartItem(userId: userId, cartId: id, title: title, imageUrl: imageUrl, quantity: cartIncr, price: price));
    
    notifyListeners();
  }

  void decrementCartItem(String id, String userId, String title, String imageUrl, double price){
    final index1 = _carts.indexWhere((element) => element.cartId == id);
   var cartDecr = _carts[index1].quantity -= 1;
    if(_carts[index1].quantity>0){
      _service.addCart(CartItem(userId: userId, cartId: id, title: title, imageUrl: imageUrl, quantity: cartDecr, price: price));
    }else{
      return;
    }
    
    notifyListeners();
  }
    
  

  // decrement cart item quantity
  // void decrementCartItem(String cartId){
  //   if(_carts.containsKey(cartId)){
  //       _carts.update(cartId, (value) => CartItem(
  //         userId: value.userId, 
  //         cartId: value.cartId, 
  //         title: value.title, 
  //         imageUrl: value.imageUrl, 
  //         quantity: value.quantity > 1 ? value.quantity - 1 : 1, 
  //         price: value.price));
  //   }
  //   notifyListeners();
  // }

  // clear cart
   clearCart() {
    _carts.clear();
    _service.deleteCart();
    notifyListeners();
  }
 
 // delete a single item
  void deleteItem(String cartId) {
      // _service.deleteCartItem(cartId);
      final index1 = _carts.indexWhere((element) => element.cartId == cartId);
      if(_carts[index1].quantity>0){
       _carts.removeAt(index1);
       _service.deleteCartItem(cartId);
      }
  
    notifyListeners();
  }
}