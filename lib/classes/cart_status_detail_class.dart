
import 'package:restourant_app/classes/cart_class.dart';

class CartStatusDetail{

  List<Cart> cart;
  bool okStatus;
  bool orderStatus;


  CartStatusDetail({this.cart,this.okStatus=false,this.orderStatus=false});

}