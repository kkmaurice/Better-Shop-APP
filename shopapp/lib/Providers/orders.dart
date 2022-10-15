// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:shopapp/Models/orders.dart';
import 'package:shopapp/Services/order_service.dart';

import '../Models/cart.dart';


class OrderProvider with ChangeNotifier{

  final OrderService _service = OrderService();
 
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  Future addToCart(List<CartItem> cartProducts, double total) async{
    await _service.addOrder(
      OrderItem(
        id: DateTime.now().toIso8601String(), 
        amount: total,
        dateTime: DateTime.now(),
        ordered: cartProducts  
        )
    );
    notifyListeners();
  }

  Future<List<OrderItem>> fetchOrders() async{
    var myOrder = await _service.getOrders();
    print('${myOrder}');
    if(myOrder is List<OrderItem>){
      _orders = myOrder;

    }
    notifyListeners();
    //print(_orders[0]);
    return _orders;
  }
  
}