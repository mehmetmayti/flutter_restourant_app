import 'dart:ffi';
import 'dart:ui';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/classes/cart_status_detail_class.dart';
import 'package:restourant_app/classes/food_class.dart';
import 'package:restourant_app/components/shooping.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Food> foods = [
    Food("Urfa Kebap", "Acısız yanında bulgur pilavı köz biber ve domates. ",
        true, "assets/slider/urfa_kebap.jpg", 32.00, "10-15 DK"),
    Food(
        "Karışık Kebap",
        "Tüm kebap ürünlreinden azar azar koyularak hazırlanır. ",
        true,
        "assets/slider/karisik.jpg",
        32.00,
        "20-30 DK"),
    Food("Çöp Şiş", "Dana antrikot kullanılarak hazırlanır. ", true,
        "assets/slider/cop_sis.jpg", 32.00, "20-30 DK"),
    Food("Kıymalı Pide", "Mevsime göre yanında salata ile servis edilir. ",
        true, "assets/slider/kiymali_pide.jpg", 32.00, "20-30 DK"),
    Food("Tombik Döner", "Kendi hazırladığımız tombik ekmeğe yapılır. ", true,
        "assets/slider/et_doner.jpg", 32.00, "20-30 DK"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    Shopping();
    super.initState();
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
                  buildMostPraferedItem(foods[1]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[2]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[3]),
                  SizedBox(height: 10),
                  buildMostPraferedItem(foods[4]),
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
            image: AssetImage(food.image),
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
    TextEditingController _customerDetailsStr = TextEditingController();
    Color portionBtnColor = Color(0xFF8BC34A);
    int _count = 1;
    Food _btmSheetfood = food;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 500,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _btmSheetfood.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Image(
                        image: AssetImage(_btmSheetfood.image),
                        height: 100,
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Yemek Hakkında Bir Not Belirtebilirsiniz',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    child: TextField(
                      maxLength: 30,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: _customerDetailsStr,
                      decoration: InputDecoration(
                        hintText: 'Soğansız, Bibersiz vb...',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Porsiyon',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: _btmSheetfood.portion == false
                                  ? portionBtnColor
                                  : Colors.white,
                              child: Text(
                                '1 Porsiyon',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            onTap: () {
                              if(_btmSheetfood.portion==true){
                                setState(() {
                                  _btmSheetfood.portion = false;
                                  _btmSheetfood.price =_btmSheetfood.price / 1.5;
                                });
                              }

                              debugPrint(_btmSheetfood.portion.toString());
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: _btmSheetfood.portion == true
                                  ? portionBtnColor
                                  : Colors.white,
                              child: Text(
                                '1-5 Porsiyon',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            onTap: () {

                              if(_btmSheetfood.portion==false){
                                setState(() {
                                  _btmSheetfood.portion = true;
                                  _btmSheetfood.price = _btmSheetfood.price * 1.5;
                                });
                              }
                              debugPrint(_btmSheetfood.portion.toString());
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black54,width: 1,style: BorderStyle.solid))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fiyat',
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          (_btmSheetfood.price * _count).toString() + ' ₺',
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      return Colors.red;
                                    },
                                  ),
                                ),
                                child: Icon(Icons.remove_circle),
                                onPressed: () {
                                  setState(() {
                                    if (_count == 1) {
                                      return null;
                                    } else {
                                      _count = _count - 1;
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                _count.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      return Colors.green;
                                    },
                                  ),
                                ),
                                child: Icon(Icons.add_circle),
                                onPressed: () {
                                  setState(() {
                                    _count = _count + 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: ElevatedButton(
                              onPressed: (){
                                _btmSheetfood.customerDetailsStr=_customerDetailsStr.text;
                                _btmSheetfood.price=_btmSheetfood.price* _count;
                                addToCart(_count,_btmSheetfood);

                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    return Colors.blueAccent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.add_shopping_cart,color: Colors.black,),
                                  Text('Sepete Ekle',style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                  ),),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  addToCart(int count, Food btmSheetfood) {
    debugPrint('Count = $count    Food Name = '+btmSheetfood.name+
        '   Food Portion = '+btmSheetfood.portion.toString()+'    Customer Details = '+btmSheetfood.customerDetailsStr.toString()
        );
    //Shopping.cartList.add(Cart(food: btmSheetfood,foodCount: count));
    //Shopping.totalPrice=Shopping.totalPrice+btmSheetfood.price;
  }
}
