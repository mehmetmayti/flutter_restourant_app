import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/classes/food_class.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Food> foods = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foods.add(
      Food(
          "Urfa Kebap",
          "Acılı yanında bulgur pilavı köz biber ve domates. ",
          true,
          "assets/slider/urfa_kebap.jpg",
          27.00,
          "10-15 Dakika"
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.blueGrey,
          child: Carousel(
            animationDuration: Duration(milliseconds: 600),
            showIndicator: false,
            images: [
              AssetImage('assets/slider/cop_sis.jpg'),
              AssetImage('assets/slider/et_doner.jpg'),
              AssetImage('assets/slider/karisik.jpg'),
              AssetImage('assets/slider/kiymali_pide.jpg'),
              AssetImage('assets/slider/urfa_kebap.jpg'),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: Colors.deepPurpleAccent,
          //height: 1000,
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.orange,
            child: Column(
              children: [
                Text('En Çok Tercih Edilenler'),
                Container(
                  child: ListView.builder(itemBuilder: )
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
