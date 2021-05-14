import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:restourant_app/main.dart';

import 'food_class.dart';

class Cart {
  int foodCount;
  Food food;

  Cart({this.foodCount, this.food});
}

class CartModel extends ChangeNotifier {
  CartModel(){
    getCartItems();
    notifyListeners();
  }
  List<Map<String,dynamic>> dblist= [];
  CollectionReference carts = FirebaseFirestore.instance.collection('carts');
  final List<Cart> cart = [];
  double totolPrice = 0;

  void setPrice(double newPrice, String op) {
    dblist.clear();
    if (op == '+') {
      this.totolPrice = this.totolPrice +newPrice;
    } else {
      this.totolPrice = this.totolPrice - newPrice;
    }

    notifyListeners();
    this.setDb();
  }

  Future<void> getCartItems() {
    carts.doc(MyApp.customer.uid).get().then((value){
      for(int i=0;i<(value.data()['foods'] as List).length;i++){
        cart.add(Cart(foodCount:value.data()['foods'][i]['foodCount'] ,food: Food(
            value.data()['foods'][i]['name'],value.data()['foods'][i]['description'],toBool(value.data()['foods'][i]['status']),
            value.data()['foods'][i]['imageUrl'],double.parse(value.data()['foods'][i]['price']),value.data()['foods'][i]['preparationTime'],
          portion:value.data()['foods'][i]['portion'],
        )));
      }
    });
    notifyListeners();
  }
  bool toBool(String str){
    if(str=='true'){
      return true;
    }
    return false;
  }

  Future<void> setCartItems(Cart cart) async {
    dblist.clear();
    this.cart.add(cart);
    notifyListeners();
    this.setDb();
  }

  Future<void> deleteCartItems(int index) {
    dblist.clear();
    this.cart.removeAt(index);
    notifyListeners();
    this.setDb();
  }

  Future<void> setDb() {
   dblist.clear();
   cart.forEach((element) {
     dblist.add({
       'foodCount':element.foodCount,
       'name':element.food.name,
       'description':element.food.description,
       'status':element.food.status.toString(),
       'imageUrl':element.food.image,
       'price':element.food.price.toString(),
       'preparationTime':element.food.preparationTime,
       'customerDetailsStr':element.food.customerDetailsStr,
       'portion':element.food.portion
     });
   });
   
   carts.doc(MyApp.customer.uid).set({
     'totalPrice':this.totolPrice.toString(),
     'foods':FieldValue.arrayUnion(dblist)
   });



  }
}
