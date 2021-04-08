import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restourant_app/classes/customer.dart';
import 'package:restourant_app/screens/login_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surName = TextEditingController();
  final TextEditingController _emailAdress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool _clickStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Kullanıcı Kaydı Oluşturma'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          labelText: 'Ad',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _surName,
                        decoration: InputDecoration(
                          labelText: 'Soyad',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailAdress,
                        decoration: InputDecoration(
                          labelText: 'E-posta',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          } else if (EmailValidator.validate(value) == false) {
                            return 'Lütfen geçerli bir E-posta adresi giriniz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password,
                        decoration: InputDecoration(
                          labelText: 'Parola',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          } else if (value.length < 6) {
                            return 'Parola en az 6 karakterden oluşmalıdır';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordControl,
                        decoration: InputDecoration(
                          labelText: 'Tekrar parola',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          } else if (value.length < 6) {
                            return 'Parola en az 6 karakterden oluşmalıdır';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _phoneNumber,
                        decoration: InputDecoration(
                          labelText: 'Telefon Numarası',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _register();
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 50,
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: _clickStatus == false
                                      ? Icon(
                                          Icons.person_add,
                                          color: Colors.white,
                                        )
                                      : SpinKitFadingCircle(
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                                Text(
                                  'Kayıt Ol',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future clickStatusChange() {
    setState(() {
      _clickStatus = true;
    });
  }

  Future<dynamic> buildFutureSpink(String value) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value),duration: Duration(milliseconds: 1500),));
    setState(() {
      _clickStatus = false;
    });
  }

  Future<void> _register() async {
    clickStatusChange();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailAdress.text, password: _password.text);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      _addUser(users, userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showSnackBar(
            'Bu E-posta hesabı zaten kullanılmakta. Lütfen giriş yapın.');
      }
    } catch (e) {
      _showSnackBar('Bir hata oluştu lütfen tekrar deneyin.');
    }
  }

  Future<void> _showSnackBar(String value) async {
    buildFutureSpink(value);
  }

  Future<void> _addUser(CollectionReference users, String id) {
    return users
        .doc(id)
        .set({
          'name': _name.text,
          'surName': _surName.text,
          'emailAdress': _emailAdress.text,
          'phoneNumber': _phoneNumber.text
        })
        .then((value) => _showSnackBar(
            'Kayıt başarıyla tamamlandı. Giriş yapmak için anasayfaya dönebilirsiniz'))
        .then((value) => _claerTextField())
        .catchError((error) {
          _showSnackBar('Bir hata oluştu. Tekrar deneyin\n$error');
          print(error);
        });
  }

  _claerTextField() {
    _name.text='';
    _surName.text='';
    _emailAdress.text='';
    _password.text='';
    _passwordControl.text='';
    _phoneNumber.text='';

  }
}
