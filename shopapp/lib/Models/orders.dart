import 'package:shopapp/Models/cart.dart';

class OrderItem {
  String id;
  double amount;
  List<CartItem> ordered;
  //List<dynamic> ordered;
  DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.ordered,
    required this.dateTime,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json){
    return OrderItem(
      id: json['id'], 
      amount: json['amount'], 
      ordered: json['ordered'] != null ? json['ordered'].map<CartItem>((item)
        {
        return CartItem(title: item['title'], quantity: item['quantity'], price: item['price'], userId: item['userId'], imageUrl: item['imageUrl'], cartId: item['cartId']);
        }
      ).toList(): [], 
      dateTime: DateTime.parse(json['dateTime']),
      );
  }
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'amount': amount,
      'dateTime': DateTime.now().toIso8601String(),
      'ordered': ordered.map((item) => {
          'id': item.cartId,
          'userId': item.userId,
          'title': item.title,
          'price': item.price,
          'imageUrl': item.imageUrl,
          'quantity': item.quantity
      }
      ).toList(),
    };
  }
}
