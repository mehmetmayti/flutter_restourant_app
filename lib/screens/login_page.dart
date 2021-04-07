

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restourant_app/screens/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.red[900],
                        Colors.red[700],
                        Colors.red[500],
                        Colors.red[300],
                      ])),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Giriş Yap",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4),
                        ),
                        SizedBox(height: 50),
                        _buildEmail(),
                        SizedBox(height: 20),
                        _buildPassword(),
                        SizedBox(height: 10),
                        _buildForgotPassBtn(),
                        _buildLoginBtn(context),
                        _buildSignupBtn(context),
                        SizedBox(height: 50),
                        _buildWithSocialMedia()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      height: 60,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black87, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.red,
          ),
          hintText: 'Email',
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      height: 60,
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.black87, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14),
          prefixIcon: Icon(
            Icons.vpn_key_sharp,
            color: Colors.red,
          ),
          hintText: 'Şifre',
        ),
      ),
    );
  }

  Widget _buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      decoration: BoxDecoration(),
      child: RaisedButton(
        elevation: 5,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'GİRİŞ',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Henüz bir üyeliğin yokmu?  ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18)),
          TextSpan(
              text: 'Üye Ol',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ]),
      ),
    );
  }

  Widget _buildWithSocialMedia() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => debugPrint('Facebook'),
            child: Image(
              image: AssetImage(
                'assets/icons/facebook.png',
              ),
              width: 60,
              height: 60,
            ),
          ),
          GestureDetector(
            onTap: () {
              print('fsasa');
            },
            child: Image(
              image: AssetImage(
                'assets/icons/search.png',
              ),
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }


}
