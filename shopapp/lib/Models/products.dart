import 'package:shopapp/Services/auth.dart';

class Product
 {
  final String userId;
  final String productId;
  final String title;
  final String description;
  final double oldPrice;
  final double price;
  final String category;
  final String name;
  final String location;
  final int phone;
  final String imageUrl;
  bool isFavorite;
  Product({
    required this.userId,
    required this.productId,
    required this.title,
    required this.description,
    required this.oldPrice,
    required this.price,
    required this.category,
    required this.name,
    required this.location,
    required this.phone,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromMap(Map<String, dynamic> data){
    return Product(
      userId: data['userId'] ?? '', 
      productId: data['productId'] ?? '', 
      title: data['title'] ?? '', 
      description: data['description'] ?? '',
      oldPrice: data['oldPrice'] ?? '', 
      price: data['price'] ?? '', 
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      name: data['ownerName'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'] as int,
      isFavorite: data['isFavorite'] ?? '', 
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': Auth().auth.currentUser!.uid,
      'productId': productId,
      'title': title,
      'description': description,
      'oldPrice': oldPrice,
      'price': price,
      'category':category,
      'ownerName': name,
      'location': location,
      'phone': phone,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
