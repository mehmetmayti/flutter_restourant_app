


import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class MenuModel extends ChangeNotifier{
  MenuModel(){
    this.getKebab();
    this.getFirin();
    this.getDoner();
    this.getMesrubat();
  }
  CollectionReference products = firestore.collection('products');

  final List<Kebab> kebabList=[];
  final List<Firin> firinList=[];
  final List<Doner> donerList=[];
  final List<Mesrubat> mesrubatList=[];

  Future<void> getKebab() async{
    await products.doc('kebap').get().then((value) {
      var dataValue=value.data();
      dataValue.values.forEach((element) {
        List list=element;
        list.forEach((element) {
          kebabList.add(Kebab(
            name: element['name'],
            imageUrl: element['imageUrl'],
            description: element['description'],
            preparationTime: element['preparationTime'],
            price:element['price'],
            status: element['status'] as bool
          ));
        });
      });
    });
    notifyListeners();
  }
  Future<void> getFirin() async{
    await products.doc('firin').get().then((value) {
      var dataValue=value.data();
      dataValue.values.forEach((element) {
        List list=element;
        list.forEach((element) {
          firinList.add(Firin(
              name: element['name'],
              imageUrl: element['imageUrl'],
              description: element['description'],
              preparationTime: element['preparationTime'],
              price:element['price'],
              status: element['status'] as bool
          ));
        });
      });
    });
    notifyListeners();
  }
  Future<void> getDoner() async{
    await products.doc('doner').get().then((value) {
      var dataValue=value.data();
      dataValue.values.forEach((element) {
        List list=element;
        list.forEach((element) {
          donerList.add(Doner(
              name: element['name'],
              imageUrl: element['imageUrl'],
              description: element['description'],
              preparationTime: element['preparationTime'],
              price:element['price'],
              status: element['status'] as bool
          ));
        });
      });
    });
    notifyListeners();
  }
  Future<void> getMesrubat() async{
    await products.doc('mesrubat').get().then((value) {
      var dataValue=value.data();
      dataValue.values.forEach((element) {
        List list=element;
        list.forEach((element) {
          mesrubatList.add(Mesrubat(
              name: element['name'],
              imageUrl: element['imageUrl'],
              price:element['price'],
              status: element['status'] as bool
          ));
        });
      });
    });
  }
  notifyListeners();
}




class Kebab{
  final String name;
  final String imageUrl;
  final String description;
  final String preparationTime;
  final String price;
  final bool status;

  Kebab({this.name, this.imageUrl, this.description, this.preparationTime, this.price, this.status});
}


class Firin{
  final String name;
  final String imageUrl;
  final String description;
  final String preparationTime;
  final String price;
  final bool status;

  Firin({this.name, this.imageUrl, this.description, this.preparationTime, this.price, this.status});
}


class Doner{
  final String name;
  final String imageUrl;
  final String description;
  final String preparationTime;
  final String price;
  final bool status;

  Doner({this.name, this.imageUrl, this.description, this.preparationTime, this.price, this.status});
}


class Mesrubat{
  final String name;
  final String imageUrl;
  final String price;
  final bool status;

  Mesrubat({this.name, this.imageUrl, this.price, this.status});
}