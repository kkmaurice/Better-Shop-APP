import 'package:shopapp/Models/products.dart';
import 'package:shopapp/Services/auth.dart';

class CartItem {
  final String userId;
  final String cartId;
  final String title;
  final String imageUrl;
  int quantity;
  final double price;
  CartItem({
    required this.userId,
    required this.cartId,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      userId: data['userId'] ?? '', 
      cartId: data['cartId'] ?? '', 
      title: data['title'] ?? '', 
      imageUrl: data['imageUrl'] ?? '', 
      quantity: data['quantity'] ?? '', 
      price: data['price'] ?? ''
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': Auth().auth.currentUser!.uid,
      'cartId': cartId,
      'title': title,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price
    };
  }

}
