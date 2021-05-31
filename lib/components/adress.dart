import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/classes/address_model.dart';

class Adress extends StatefulWidget {
  @override
  _AdressState createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  TextEditingController addressTitle = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController addressDescription = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressModel>(builder: (context, model, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              buildShowModalBottomSheet(context, model);
              //model.addAdress(AddressModel(
              //    address: 'fsafsfsafwreteqafsaf',
              //    addressDescription: 'gdds',
              //    addressTitle: 'iş'));
            },
          ),
          body: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(),
                Expanded(
                  child: model.addressList.length == 0
                      ? buildEmptyChild()
                      : buildList(model),
                  flex: 20,
                )
              ],
            ),
          ));
    });
  }

  Future buildShowModalBottomSheet(BuildContext context, AddressModel model) {
    return showModalBottomSheet(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: 500,
              child: Form(
                key: form,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: addressTitle,
                        decoration: InputDecoration(
                            labelText: 'Adres Başlığı',
                            hintText: 'Ev veya İş Adresim gibi..'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      )),
                      Expanded(
                          child: TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                            labelText: 'Adres',
                            hintText:
                                'Mahalle Sokak Cadde Blok gibi detayları yazınız..'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      )),
                      Expanded(
                          child: TextFormField(
                        controller: addressDescription,
                        decoration: InputDecoration(
                            labelText: 'Açıklama',
                            hintText: 'Belirleyici açıklama ekleyiniz..'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          }
                          return null;
                        },
                      )),
                      Container(
                        child: ElevatedButton(
                          child: Text(
                            'Adresi Kaydet',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if (form.currentState.validate()) {
                              model.addAdress(AddressModel(
                                  address: address.text,
                                  addressDescription: addressDescription.text,
                                  addressTitle: addressTitle.text));
                              address.text = '';
                              addressTitle.text = '';
                              addressDescription.text = '';
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        context: context);
  }

  Widget buildList(AddressModel model) {
    return Container(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            minVerticalPadding: 16.0,
            contentPadding: EdgeInsets.all(5.0),
            title: Text(
              model.addressList[index].addressTitle,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(model.addressList[index].address +
                '\n' +
                model.addressList[index].addressDescription),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    child: Icon(
                        Icons.delete,
                        color: Colors.red),
                  onTap: (){
                      model.deleteAdress(index);
                  },
                ),
              ],
            ));
      },
      itemCount: model.addressList.length,
    ));
  }

  Widget buildEmptyChild() {
    return Center(
        child: Text(
      'Kayıtlı Adresiniz Bulunmamaktadır.',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    ));
  }

  Expanded buildTitle() {
    return Expanded(
      child: Text(
        'Adreslerim',
        style: TextStyle(fontSize: 18),
      ),
      flex: 1,
    );
  }
}
