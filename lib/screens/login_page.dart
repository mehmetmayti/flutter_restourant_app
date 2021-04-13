import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:restourant_app/classes/customer.dart';
import 'package:restourant_app/main.dart';
import 'package:restourant_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restourant_app/screens/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  static FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String phoneControl = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scafoldKey,
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
        controller: _email,
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
        controller: _password,
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
          if (_email.text == '' || _password.text == '') {
            _showSnackBar('Lütfen alanları eksiksiz doldurun!');
          }
          _signIn(context).then((value) => _clearTextFiled());
        },
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
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
            onTap: () {
              signInWithGoogle();
              //_phoneControl();
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

  Future<void> _signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      print(userCredential.user.uid);
      _getCustomer(userCredential.user.uid).then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackBar('Böyle bir hesap bulunumadı.');
      } else if (e.code == 'wrong-password') {
        _showSnackBar('Parolayı hatalı girdiniz lütfen tekrar deneyin.');
      } else {
        _showSnackBar('Lütfen alanları düzgün bir şekilde doldurun');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  _showSnackBar(String value) {
    ScaffoldMessenger.of(_scafoldKey.currentContext).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> _getCustomer(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Customer _customer = Customer();
        _customer.name = documentSnapshot['name'].toString();
        _customer.surName = documentSnapshot['surName'].toString();
        _customer.emailAdress = documentSnapshot['emailAdress'].toString();
        _customer.phoneNumber = documentSnapshot['phoneNumber'].toString();

        print(_customer.name);
        MyApp.customer = _customer;
        print(MyApp.customer.name);
      } else {
        _showSnackBar('Bir hata oluştu lütfen tekrar deneyin.');
      }
    });
  }

  void _clearTextFiled() {
    _email.text = '';
    _password.text = '';
  }
}
