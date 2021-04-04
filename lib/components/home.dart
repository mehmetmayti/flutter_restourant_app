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
      Food("Urfa Kebap", "Acısız yanında bulgur pilavı köz biber ve domates. ",
          true, "assets/slider/urfa_kebap.jpg", 27.00, "10-15 Dakika"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        buildImageSlider(),
        Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              //height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              //color: Colors.lightGreenAccent,
              child: Column(
                children: [
                  buildMostPrefaredContainerTitle(),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[0]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[0]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[0]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[0]),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  Container buildMostPraferedItem(Food food) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(2, 2))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      //color: Colors.brown,
      child: Column(children: [
        ListTile(
          title: Text(food.name),
          subtitle: Text(food.description),
          trailing: Text(food.price.toString() + ' ₺'),
          leading: Image(
            image: AssetImage('assets/slider/urfa_kebap.jpg'),
          ),
          contentPadding: EdgeInsets.only(left: 0),
          onTap: () => _showBottomSheet(food),
        ),
      ]),
    );
  }

  Container buildMostPrefaredContainerTitle() {
    return Container(
      child: Text(
        'En Çok Tercih Edilenler',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              Shadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 5)
            ]),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  Container buildImageSlider() {
    return Container(
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
    );
  }

  _showBottomSheet(Food food) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF737373),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          height: 500,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),

                  ),
                  Image(
                    image: AssetImage(food.image),
                    height: 100,
                  ),
                ],
              ),
              Divider(height: 20,color: Colors.black,),
              
            ],
          ),
        );
      },
    );
  }
}
