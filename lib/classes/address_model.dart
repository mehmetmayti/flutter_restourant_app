
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/main.dart';

class AddressModel extends ChangeNotifier{

  final addressTitle;
  final address;
  final addressDescription;

  AddressModel({this.address,this.addressDescription,this.addressTitle});
  List<AddressModel> addressList=[];
  List<Map<String,dynamic>> dbAddressList=[];
  CollectionReference reference=FirebaseFirestore.instance.collection('address');

  Future<void> getAddressList(){
    reference.doc(MyApp.customer.uid).get().then((value) {
      (value.data()['address'] as List).forEach((element) {
        setAddressListLocal(AddressModel(
          address: element['address'],
          addressTitle: element['addressTitle'],
          addressDescription: element['addressDescription']
        ));
      });
    });
  }

  void setAddressListLocal(AddressModel model){
    addressList.add(model);
    notifyListeners();
  }
  Future<void> addAdress(AddressModel model){

    this.setAddressListLocal(model);
    setDb();
    notifyListeners();
  }

  Future<void> setDb() async{
    addressList.forEach((element) {
      dbAddressList.add({
        'addressTitle':element.addressTitle,
        'address':element.address,
        'addressDescription':element.addressDescription
      });
    });
    reference.doc(MyApp.customer.uid).delete().then((value) {
      reference.doc(MyApp.customer.uid).set({
        'address': FieldValue.arrayUnion(dbAddressList)
      });
    });

  }
  Future<void> deleteAdress(int index){
    addressList.removeAt(index);
    setDb();

    notifyListeners();
  }



}