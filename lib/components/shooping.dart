import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/classes/cart_status_detail_class.dart';
import 'package:restourant_app/classes/food_class.dart';
import 'package:restourant_app/classes/menu_model.dart';




class Shopping extends StatefulWidget {
  static List<Cart> cartList = [];
  static double totalPrice = 0;
  static CartStatusDetail cartStatusDetail = CartStatusDetail(cart: cartList);
  @override
  _ShoppingState createState() =>
      _ShoppingState(cartList, cartStatusDetail, totalPrice);
}



class _ShoppingState extends State<Shopping> {
  List<Cart> cartList2 = [];
  CartStatusDetail _cartStatusDetail;
  double _totalPrice = 0;
  _ShoppingState(this.cartList2, this._cartStatusDetail, this._totalPrice);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context,cartlist,child){
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
                child: _cartStatusDetail.okStatus == true || cartlist.cart.length == 0
                    ? buildEmptyCart()
                    : buildCartItems(cartlist.cart),
                flex: 9,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  //color: Colors.teal,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                'Toplam Ödenecek Fiyat',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cartlist.totolPrice.toString()+' ₺',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.card_travel),
                                Text(
                                  'Sepeti Onayla',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      );
    });
  }

  Container buildEmptyCart() => Container(
        child: Center(
          child: Text(
            'Sepet Boş',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black12),
          ),
        ),
      );

  Container buildCartItems(List<Cart> cart) {
    return Container(
      width: double.infinity,
      //height: 450,
      //color: Colors.red,
      child: ListView.builder(
        itemBuilder: (context, index) {
          String portion =
              cart[index].food.portion == false ? '' : '1.5 Porsiyon';

          return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black54, width: 1))),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCartItemImage(index,cart), //Image
                buildCartItemBody(index, portion,cart), //Body
                buildCartItemRight(index,cart), //Righth
              ],
            ),
          );
        },
        itemCount: cart.length,
      ),
    );
  }

  Expanded buildCartItemRight(int index,List<Cart> cart) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              cart[index].foodCount.toString() + ' Adet',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cart[index].food.price.toString() + ' ₺',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {

                      Provider.of<CartModel>(context,listen: false).setPrice(cart[index].food.price, '-');
                      Provider.of<CartModel>(context,listen: false).deleteCartItems(index);

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

  Expanded buildCartItemBody(int index, String portion,List<Cart> cart) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                cart[index].food.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: Text(
                ' '+cart[index].food.customerDetailsStr,
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
                      Text(' ' + cart[index].food.preparationTime)
                    ],
                  ),
                ),
                Container(
                  child: Text(portion),
                )
              ],
            )),
          ],
        ),
        padding: EdgeInsets.all(10),
      ),
      flex: 6,
    );
  }

  Expanded buildCartItemImage(int index,List<Cart> cart) {
    return Expanded(
      child: Container(
        child: Image(
          image: NetworkImage(cart[index].food.image),
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
      child: Text(
        'Sepetim',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }
}
