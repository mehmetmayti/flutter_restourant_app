import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/classes/food_class.dart';
import 'package:restourant_app/classes/menu_model.dart';

import 'shooping.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(builder: (context, menu, child) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Menu'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              labelPadding: EdgeInsets.all(10),
              isScrollable: true,
              tabs: [
                Text(
                  "Kebap Çeşitleri",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Döner Çeşitleri",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Fırın Çeşitleri",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "İçecek Çeşitleri",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              KebapCesitleri(),
              DonerCesitleri(),
              FirinCesitleri(),
              MesrubatCesitleri(),
            ],
          ),
        ),
      );
    });
  }

  static showBottomSheetKebab(Kebab kebab, BuildContext context) {
    TextEditingController _customerDetailsStr = TextEditingController();
    Color portionBtnColor = Color(0xFF8BC34A);
    int _count = 1;
    Food _btmSheetfood = Food(kebab.name, kebab.description, kebab.status,
        kebab.imageUrl, double.parse(kebab.price), kebab.preparationTime);
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: StatefulBuilder(
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
                        Expanded(
                            child: Text(
                          _btmSheetfood.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )),
                        Image(
                          image: NetworkImage(_btmSheetfood.image),
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
                            if (_btmSheetfood.portion == true) {
                              setState(() {
                                _btmSheetfood.portion = false;

                              });
                              _btmSheetfood.price = _btmSheetfood.price / 1.5;
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
                            if (_btmSheetfood.portion == false) {
                              setState(() {
                                _btmSheetfood.portion = true;

                              });
                              _btmSheetfood.price = _btmSheetfood.price * 1.5;
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
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                  style: BorderStyle.solid))),
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
                            onPressed: () {
                              _btmSheetfood.customerDetailsStr =
                                  _customerDetailsStr.text;
                              _btmSheetfood.price =_btmSheetfood.price*_count;
                              addToCart(_count, _btmSheetfood, context);

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
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  static showBottomSheetDoner(Doner doner, BuildContext context) {
    TextEditingController _customerDetailsStr = TextEditingController();
    Color portionBtnColor = Color(0xFF8BC34A);
    int _count = 1;
    Food _btmSheetfood = Food(doner.name, doner.description, doner.status,
        doner.imageUrl, double.parse(doner.price), doner.preparationTime);
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: StatefulBuilder(
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
                        Expanded(
                          child: Text(
                            _btmSheetfood.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Image(
                          image: NetworkImage(_btmSheetfood.image),
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
                            if (_btmSheetfood.portion == true) {
                              setState(() {
                                _btmSheetfood.portion = false;
                                _btmSheetfood.price = _btmSheetfood.price / 1.5;
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
                            if (_btmSheetfood.portion == false) {
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
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                  style: BorderStyle.solid))),
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
                            onPressed: () {
                              _btmSheetfood.customerDetailsStr =
                                  _customerDetailsStr.text;
                              _btmSheetfood.price = _btmSheetfood.price*_count;
                              addToCart(_count, _btmSheetfood, context);

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
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  static showBottomSheetFirin(Firin firin, BuildContext context) {
    TextEditingController _customerDetailsStr = TextEditingController();
    Color portionBtnColor = Color(0xFF8BC34A);
    int _count = 1;
    Food _btmSheetfood = Food(firin.name, firin.description, firin.status,
        firin.imageUrl, double.parse(firin.price), firin.preparationTime);
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: StatefulBuilder(
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
                        Expanded(
                          child: Text(
                            _btmSheetfood.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(_btmSheetfood.image),
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
                            if (_btmSheetfood.portion == true) {
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
                            if (_btmSheetfood.portion == false) {
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
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                  style: BorderStyle.solid))),
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
                            onPressed: () {
                              _btmSheetfood.customerDetailsStr =
                                  _customerDetailsStr.text;
                              _btmSheetfood.price = _btmSheetfood.price*_count;
                              addToCart(_count, _btmSheetfood, context);

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
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  static showBottomSheetMesrubat(Mesrubat mesrubat, BuildContext context) {
    TextEditingController _customerDetailsStr = TextEditingController();
    int _count = 1;
    Food _btmSheetfood = Food(
      mesrubat.name,
      '',
      mesrubat.status,
      mesrubat.imageUrl,
      double.parse(mesrubat.price),
      '',
    );
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: StatefulBuilder(
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
                        Expanded(
                          child: Text(
                            _btmSheetfood.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Image(
                          image: NetworkImage(_btmSheetfood.image),
                          height: 100,
                        ),
                      ],
                    ),
                    Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                    style: BorderStyle.solid))),
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
                            onPressed: () {
                              _btmSheetfood.customerDetailsStr =
                                  _customerDetailsStr.text;
                              _btmSheetfood.price = _btmSheetfood.price*_count;
                              addToCart(_count, _btmSheetfood, context);

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
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  static addToCart(int count, Food btmSheetfood, BuildContext context) {
    Provider.of<CartModel>(context, listen: false)
        .setCartItems(Cart(food: btmSheetfood, foodCount: count));
    Provider.of<CartModel>(context, listen: false).setPrice(btmSheetfood.price,'+');
  }
}

class KebapCesitleri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(builder: (context, menu, child) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              //color: Colors.brown,
              child: Column(children: [
                ListTile(
                    minVerticalPadding: 10,
                    title: Text(menu.kebabList[index].name),
                    subtitle: Text(menu.kebabList[index].description),
                    trailing:
                        Text(menu.kebabList[index].price.toString() + ' ₺'),
                    leading: Image(
                        image: NetworkImage(menu.kebabList[index]
                            .imageUrl) //AssetImage(menu.kebabList[index].imageUrl),
                        ),
                    contentPadding: EdgeInsets.only(left: 0),
                    onTap: () => Menu.showBottomSheetKebab(
                        menu.kebabList[index], context)),
              ]),
            );
          },
          itemCount: menu.kebabList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 5,
              ));
    });
  }
}

class FirinCesitleri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(builder: (context, menu, child) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              //color: Colors.brown,
              child: Column(children: [
                ListTile(
                    minVerticalPadding: 10,
                    title: Text(menu.firinList[index].name),
                    subtitle: Text(menu.firinList[index].description),
                    trailing:
                        Text(menu.firinList[index].price.toString() + ' ₺'),
                    leading: Image(
                        image: NetworkImage(menu.firinList[index]
                            .imageUrl) //AssetImage(menu.kebabList[index].imageUrl),
                        ),
                    contentPadding: EdgeInsets.only(left: 0),
                    onTap: () => Menu.showBottomSheetFirin(
                        menu.firinList[index], context)),
              ]),
            );
          },
          itemCount: menu.firinList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 5,
              ));
    });
  }
}

class DonerCesitleri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(builder: (context, menu, child) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              //color: Colors.brown,
              child: Column(children: [
                ListTile(
                  minVerticalPadding: 10,
                  title: Text(menu.donerList[index].name),
                  subtitle: Text(menu.donerList[index].description),
                  trailing: Text(menu.donerList[index].price.toString() + ' ₺'),
                  leading: Image(
                      image: NetworkImage(menu.donerList[index]
                          .imageUrl) //AssetImage(menu.kebabList[index].imageUrl),
                      ),
                  contentPadding: EdgeInsets.only(left: 0),
                  onTap: () =>
                      Menu.showBottomSheetDoner(menu.donerList[index], context),
                ),
              ]),
            );
          },
          itemCount: menu.donerList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 5,
              ));
    });
  }
}

class MesrubatCesitleri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(builder: (context, menu, child) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              //color: Colors.brown,
              child: Column(children: [
                ListTile(
                    minVerticalPadding: 10,
                    title: Text(menu.mesrubatList[index].name),
                    trailing:
                        Text(menu.mesrubatList[index].price.toString() + ' ₺'),
                    leading: Image(
                        image: NetworkImage(menu.mesrubatList[index]
                            .imageUrl) //AssetImage(menu.kebabList[index].imageUrl),
                        ),
                    contentPadding: EdgeInsets.only(left: 0),
                    onTap: () => Menu.showBottomSheetMesrubat(
                        menu.mesrubatList[index], context)),
              ]),
            );
          },
          itemCount: menu.mesrubatList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 5,
              ));
    });
  }
}
