import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restourant_app/classes/address_model.dart';
import 'package:restourant_app/classes/cart_class.dart';
import 'package:restourant_app/classes/order_model.dart';
import 'package:restourant_app/main.dart';

// ignore: must_be_immutable
class OrderApprove extends StatefulWidget {
  @override
  _OrderApproveState createState() => _OrderApproveState();
}

class _OrderApproveState extends State<OrderApprove> {
  TextEditingController nameSurname = TextEditingController(
      text: MyApp.customer.name + ' ' + MyApp.customer.surName);
  TextEditingController orderNote = TextEditingController();
  TextEditingController phoneNumber =
      TextEditingController(text: MyApp.customer.phoneNumber);
  AddressModel selectedAddress;
  String paymentType = 'Nakit';
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderModel>(builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sipariş Onay'),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNameSurname(),
              buildPhoneNumber(),
              buildOrderNote(),
              SizedBox(
                height: 5,
              ),
              Text(
                'Adres',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  flex: 4,
                  child: buildAddressListCard(context,
                      Provider.of<AddressModel>(context, listen: false))),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ödeme Yöntemi',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              buildPaymentType(),
              SizedBox(
                height: 5,
              ),
              buildBottom(context)
            ],
          ),
        ),
      );
    });
  }

  Expanded buildBottom(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(12),
        color: Colors.black12,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Toplam Sipariş Tutarı',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    Provider.of<CartModel>(context, listen: false)
                            .totolPrice
                            .toString() +
                        ' ₺',
                    style: TextStyle(fontSize: 22),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
            Expanded(
              child: ElevatedButton(
                child: Text(
                  'Siparişi Gönder',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                onPressed: () {
                  if (phoneNumber.text == '') {
                    buildShowDialog(
                        context,
                        Icons.error,
                        'Lütfen telefon numarası alanını boş bırakmayınız !',
                        Colors.red,
                        false);
                  } else if (selectedAddress == null) {
                    buildShowDialog(
                        context,
                        Icons.error,
                        'Adres seçimi yapmadan sipariş gönderimi sağlanamaz !',
                        Colors.red,
                        false);
                  } else {
                    OrderModel orderModel = OrderModel(
                        adress: selectedAddress,
                        phoneNumber: phoneNumber.text,
                        customerNameSurname: nameSurname.text,
                        customerNote: orderNote.text,
                        paymentType: paymentType,
                        totalPrice:
                            Provider.of<CartModel>(context, listen: false)
                                .totolPrice
                                .toString());

                    orderModel
                        .setOrder(
                            cartModel:
                                Provider.of<CartModel>(context, listen: false),
                            orderModel: orderModel)
                        .then((value) {
                      buildShowDialog(context, Icons.error,
                          'Siapriş Gönderimi Başarılı', Colors.green, true);
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future buildShowDialog(BuildContext context, IconData icon, String message,
      Color color, bool okStatus) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    size: 50,
                    color: color,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Sipariş Onay Sayfası Mesajı'),
                ],
              ),
              content: Text(message),
              actions: [
                okStatus == true
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('Ok'))
                    : TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'))
              ],
            ));
  }

  Expanded buildOrderNote() {
    return Expanded(
        flex: 2,
        child: TextFormField(
          controller: orderNote,
          decoration: InputDecoration(
              labelText: 'Sipariş Notu Giriniz',
              helperText: 'Zorunlu değildir'),
        ));
  }

  Expanded buildNameSurname() {
    return Expanded(
        child: TextFormField(
      controller: nameSurname,
      decoration: InputDecoration(
        labelText: 'Siparişi Alıcak Kişi',
      ),
    ));
  }

  Expanded buildPhoneNumber() {
    return Expanded(
        child: TextFormField(
      enabled: phoneNumber.text == '' ? true : false,
      controller: phoneNumber,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
      decoration: InputDecoration(
        labelText: 'Telefon Numarası*',
      ),
    ));
  }

  Expanded buildPaymentType() {
    return Expanded(
        child: DropdownButton<String>(
            value: paymentType,
            underline: Container(
              height: 2,
              color: Colors.red,
            ),
            onChanged: (String newValue) {
              setState(() {
                paymentType = newValue;
              });
            },
            items: [
              'Nakit',
              'Kredi/Banka Kartı',
              'Yemek Çeki',
              'Setcart',
              'Metropol'
            ].map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList()));
  }

  buildAddressListCard(BuildContext context, AddressModel model) {
    if (model.addressList.isEmpty) {
      return Center(
        child: Text('Kayıtlı Adres Bulunmamakta'),
      );
    } else {
      return Card(
        child: ListView.builder(
            itemCount: model.addressList.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: ListTile(
                  title: Text(model.addressList[i].addressTitle),
                  subtitle: Text(model.addressList[i].address),
                  trailing: selectedAddress == model.addressList[i]
                      ? Icon(
                          Icons.radio_button_checked_sharp,
                          color: Colors.red,
                        )
                      : Icon(Icons.radio_button_off),
                ),
                onTap: () {
                  setState(() {
                    selectedAddress = model.addressList[i];
                  });
                },
              );
            }),
      );
    }
  }
}
