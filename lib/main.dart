
import 'package:flutter/material.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/classes/menu_model.dart';
import 'package:restourant_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'classes/customer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MenuModel()),
        ChangeNotifierProvider(create: (context)=>CartModel()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  static Customer customer =new Customer();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

