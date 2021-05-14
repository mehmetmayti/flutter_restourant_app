import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/classes/customer.dart';
import 'package:restourant_app/classes/menu_model.dart';
import 'package:restourant_app/components/adress.dart';
import 'package:restourant_app/components/customer_settings.dart';
import 'package:restourant_app/components/home.dart';
import 'package:restourant_app/components/menu.dart';
import 'package:restourant_app/components/shooping.dart';
import 'package:restourant_app/main.dart';
import 'package:restourant_app/screens/login_page.dart';


class HomePage extends StatefulWidget {
  MenuModel model=MenuModel();
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int _index = 2;
  List pageList = [
    Adress(),
    Menu(),
    Home(),
    Shopping(),
    CustomerSetings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Icon(Icons.person),
          title: Text("Hoşgeldin ${MyApp.customer.name}"),
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              child: Padding(
                child: GestureDetector(
                  child: Icon(Icons.login_outlined),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                padding: EdgeInsets.only(right: 10),
              ),
              onTap: () => debugPrint("Sepet"),
            )
          ],
        ),
        bottomNavigationBar: getBottoNavBar(),
        body: pageList[_index],
      ),
    );
  }

  getBottoNavBar() {
    return CurvedNavigationBar(
      color: Colors.red,
      height: 50,
      index: 2,
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.red,
      items: [
        Icon(
          Icons.map,
          color: Colors.white,
        ),
        Icon(
          Icons.restaurant_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Stack(
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            Positioned(
                left: 14,
                bottom: 8,
                child: Text(
                  Shopping.cartList.length.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Shopping.cartList.length == 0
                          ? Colors.transparent
                          : Colors.black87),

                )
            ),
          ],
        ),
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
    );
  }


}
