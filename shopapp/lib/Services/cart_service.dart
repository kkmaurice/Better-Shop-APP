import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/Models/cart.dart';

class CartService{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('cart');

  // add cart to firebase
  Future addCart(CartItem cart) async{
    await _ref
          .doc(cart.cartId)
          .set(cart.toMap(), SetOptions(merge: true));
  }

  // get products from the firebase
  Future getCart() async{
    try{
     var myDocuments = await  _ref.get();
    if (myDocuments.docs.isNotEmpty){
      return myDocuments
              .docs
              .map((snapshot) => 
              CartItem.fromMap(snapshot.data() as Map<String, dynamic>)).toList();
            
    }
    } catch(e){
      if( e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
 
 //delete single cartItem
  Future<void> deleteCartItem(String cartId) async{
    return await _ref.doc(cartId).delete();
  }
  
// delete all
  Future<void> deleteCart() async{
    //return await _ref.doc().delete();
    var doc = await _ref.get();
          for (var ds in doc.docs){
            ds.reference.delete();
          }
  }

  Future updateCart(CartItem cart) async{
    try{
      await _ref
            .doc(cart.cartId)
            .update(cart.toMap());
        return true;
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
}
