import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/Models/cart.dart';
import 'package:shopapp/Models/orders.dart';

class OrderService{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('orders');

  // add cart to firebase
  Future addOrder(OrderItem order) async{
    await _ref
          .doc(order.id)
          .set(order.toMap(), SetOptions(merge: true));
  }

  // get products from the firebase
  Future getOrders() async{
    try{
      await _ref.get();
     var myDocuments = await  _ref.get();
    if (myDocuments.docs.isNotEmpty){
      return myDocuments
              .docs
              .map((snapshot) => 
              OrderItem.fromMap(snapshot.data() as Map<String, dynamic>)).toList();
            
    }
    } catch(e){
      if( e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
}