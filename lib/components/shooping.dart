import 'package:flutter/material.dart';
import 'package:restourant_app/classes/cart_class.dart';



// ignore: must_be_immutable
class Shopping extends StatefulWidget {
  static List<Cart> cartList=[];
  @override
  _ShoppingState createState() => _ShoppingState(cartList);
}

class _ShoppingState extends State<Shopping> {

  List<Cart> cartList2=[];
  _ShoppingState(this.cartList2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Show Cart List in Debug Print'),
          onPressed: (){
            for(var i in cartList2) debugPrint('Count = '+i.foodCount.toString()+'    Food Name = '+i.food.name+
                '   Food Portion = '+i.food.portion.toString()+'    Customer Details = '+i.food.customerDetailsStr.toString()
            );
          },
        ),
      )
    );
  }
}
