import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/components/adress.dart';
import 'package:restourant_app/components/customer_settings.dart';
import 'package:restourant_app/components/home.dart';
import 'package:restourant_app/components/menu.dart';
import 'package:restourant_app/components/shooping.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String customer = 'Mehmet';
  int _index=2;
  List pageList=[
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
          title: Text("Hoşgeldin $customer"),
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              child: Padding(
                child: Icon(Icons.shopping_cart),
                padding: EdgeInsets.only(right: 10),
              ),
              onTap: () => debugPrint("Sepet"),
            )
          ],
        ),
        bottomNavigationBar:getBottoNavBar(),
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
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
      onTap: (index){
        setState(() {
          _index=index;
        });
      },
    );
  }
}
