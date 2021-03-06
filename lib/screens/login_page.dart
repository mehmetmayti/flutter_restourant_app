import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                          "Giri?? Yap",
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
          hintText: '??ifre',
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
          '??ifremi Unuttum',
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
          'G??R????',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        onPressed: () {
          if (_email.text == '' || _password.text == '') {
            _showSnackBar('L??tfen alanlar?? eksiksiz doldurun!');
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
              text: 'Hen??z bir ??yeli??in yokmu?  ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18)),
          TextSpan(
              text: '??ye Ol',
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
        _showSnackBar('B??yle bir hesap bulunumad??.');
      } else if (e.code == 'wrong-password') {
        _showSnackBar('Parolay?? hatal?? girdiniz l??tfen tekrar deneyin.');
      } else {
        _showSnackBar('L??tfen alanlar?? d??zg??n bir ??ekilde doldurun');
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

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      addUser(value.user.uid, value.user.displayName.split(' ')[0],
          value.user.displayName.split(' ')[1], value.user.email);
    });
  }

  Future<dynamic> _showSnackBar(String value) async {
    ScaffoldMessenger.of(_scafoldKey.currentContext).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 2),
    ));
  }

  Future<dynamic> _getCustomer(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Customer _customer = Customer();
        _customer.uid=uid;
        _customer.name = documentSnapshot['name'].toString();
        _customer.surName = documentSnapshot['surName'].toString();
        _customer.emailAdress = documentSnapshot['emailAdress'].toString();
        _customer.phoneNumber = documentSnapshot['phoneNumber'].toString();
        MyApp.customer = _customer;
      } else {
        _showSnackBar('Bir hata olu??tu l??tfen tekrar deneyin.!!!');
      }
    }).then((value) => Navigator.push(_scafoldKey.currentContext,
        MaterialPageRoute(builder: (context) => HomePage())));
  }

  void _clearTextFiled() {
    _email.text = '';
    _password.text = '';
  }

  Future<dynamic> addUser(
      String id, String name, String surName, String email) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    await user.doc(id).get().then((value) {
      if (value.exists) {
        return null;
      } else {
        user.doc(id).set({
          'name': name,
          'surName': surName,
          'emailAdress': email,
          'phoneNumber': ''
        }).catchError(
            (error) => _showSnackBar('Bir hata olu??tu tekrar deneyin!'));
      }
    });
    _getCustomer(id);
  }
}
