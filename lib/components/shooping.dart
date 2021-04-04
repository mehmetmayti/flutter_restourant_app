import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restourant_app/classes/cart_class.dart';

// ignore: must_be_immutable
class Shopping extends StatefulWidget {
  static List<Cart> cartList = [];
  @override
  _ShoppingState createState() => _ShoppingState(cartList);
}

class _ShoppingState extends State<Shopping> {
  List<Cart> cartList2 = [];
  _ShoppingState(this.cartList2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildTitleMyCart(),
            Container(
              width: double.infinity,
              height: 450,
              //color: Colors.red,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Image(
                              image: AssetImage(cartList2[index].food.image),
                              width: 80,
                            ),
                            padding: EdgeInsets.only(left: 0,top: 10),
                          ),
flex: 2,
                        ), //Image
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    cartList2[index].food.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    cartList2[index].food.customerDetailsStr,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer_rounded,
                                        size: 14,
                                      ),
                                      Text(' ' +
                                          cartList2[index].food.preparationTime)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          flex: 6,

                        ), //Body
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  cartList2[index].foodCount.toString() + ' Adet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(data)
                                  ],
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          flex: 2,
                        ), //Righth
                      ],
                    ),
                  );
                },
                itemCount: cartList2.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTitleMyCart() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        'Sepetim',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }
}
