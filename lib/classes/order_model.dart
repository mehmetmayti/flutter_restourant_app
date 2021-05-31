import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/classes/address_model.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/main.dart';
import 'package:intl/date_symbol_data_local.dart';


class OrderModel extends ChangeNotifier{

  final df = DateFormat.Hm('tr_TR');
  final String totalPrice;
  final String customerNameSurname;
  final String customerNote;
  final String paymentType;
  final AddressModel adress;
  final String phoneNumber;
  List<Map<String,dynamic>> foodList=[];
  bool isCancel=false;//iptal edilme durumu
  bool isMaking=false;//hazırlanma durumu
  bool isSubmission=false;//müşteriye gönderilme durumu yoldamı-değilmi
  bool isOkkay=false;//Restorant onay durumu

  CollectionReference reference = FirebaseFirestore.instance.collection('orders');

  OrderModel({this.totalPrice, this.customerNote,this.paymentType,this.adress,this.phoneNumber,this.customerNameSurname});

  Future<void> cartListToFoodLis(CartModel cartModel)async{
    cartModel.cart.forEach((element) {
      foodList.add({
        'count': element.foodCount,
        'portion': element.food.portion,
        'price': element.food.price.toString(),
        'foodName': element.food.name
      });
    });

  }


  Future<void> setOrder({CartModel cartModel,OrderModel orderModel}) async{
    await this.cartListToFoodLis(cartModel).then((value) {
      reference.doc(MyApp.customer.uid).set({
        'isCancel':orderModel.isCancel,
        'totalPrice':orderModel.totalPrice,
        'customerNameSurname':orderModel.customerNameSurname,
        'customerNote':orderModel.customerNote,
        'paymentType':orderModel.paymentType,
        'address':{
          'address':orderModel.adress.address,
          'addressDetails':orderModel.adress.addressDescription
        },
        'phoneNumber':orderModel.phoneNumber,
        'foods':FieldValue.arrayUnion(this.foodList),
        'isMaking':orderModel.isMaking,
        'isSubmission':orderModel.isSubmission,
        'isOkkay':orderModel.isOkkay,
        'date':df.format(DateTime.now())
      }).then((value) {
        cartModel.deleteDbCart();
      });
    });

  }


}