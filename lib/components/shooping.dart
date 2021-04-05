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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: buildTitleMyCart(),
              flex: 1,
            ),
            Expanded(
              child: buildCartItems(),
              flex: 9,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.teal,
                padding: EdgeInsets.all( 10),
                child: Text("data"),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Container buildCartItems() {
    return Container(

      width: double.infinity,
      height: 450,
      //color: Colors.red,
      child: ListView.builder(
        itemBuilder: (context, index) {
          String portion =
              cartList2[index].food.portion == false ? '' : '1.5 Porsiyon';

          return Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black54,width: 1))
            ),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCartItemImage(index), //Image
                buildCartItemBody(index,portion), //Body
                buildCartItemRight(index ), //Righth
              ],
            ),
          );
        },
        itemCount: cartList2.length,
      ),
    );
  }

  Expanded buildCartItemRight(int index) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              cartList2[index].foodCount.toString() + ' Adet',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartList2[index].food.price.toString() + ' ₺',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    setState(() {
                      cartList2.removeAt(index);
                    });
                  },
                )
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.all(10),
      ),
      flex: 3,
    );
  }

  Expanded buildCartItemBody(int index,String portion) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                cartList2[index].food.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: Text(
                cartList2[index].food.customerDetailsStr,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_rounded,
                          size: 14,
                        ),
                        Text(' ' + cartList2[index].food.preparationTime)
                      ],
                    ),
                  ),
                  Container(
                    child: Text(portion),
                  )
                ],
              )
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
      ),
      flex: 6,
    );
  }

  Expanded buildCartItemImage(int index) {
    return Expanded(
      child: Container(
        child: Image(
          image: AssetImage(cartList2[index].food.image),
          width: 80,
        ),
        padding: EdgeInsets.only(left: 0, top: 10),
      ),
      flex: 2,
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
