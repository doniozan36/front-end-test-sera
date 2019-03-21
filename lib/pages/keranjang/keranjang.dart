import 'package:flutter/material.dart';
import 'dart:convert';
import '../../resources/environment.dart';
import '../../resources/session.dart';

class Keranjang extends StatefulWidget {
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  List<dynamic> listKeranjang = [];
  int totalCart = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    await getCart();
    await getTotalCart();
  }

  Future getCart() async {
    var cart = await Session.getPrefs('cart');
    listKeranjang = [];
    if(cart != null){
      var cartDecode = json.decode(cart);
      setState(() {
        for (var i = 0; i < cartDecode.length; i++) {
          listKeranjang.add(cartDecode[i]);
        }
      });
    }
  }

  Future getTotalCart() async {
    var cart = await Session.getPrefs('cart');
    totalCart = 0;
    if(cart != null){
      var cartDecode = json.decode(cart);
      setState(() {
        for (var i = 0; i < cartDecode.length; i++) {
          totalCart += cartDecode[i]['price'] * cartDecode[i]['qty'];
        }
      });
    }
  }

  changeJumlah(String condition,int id) async {
    var decodeCart = json.decode(await Session.getPrefs('cart'));
    for (var i = 0; i < decodeCart.length; i++) {
      if(decodeCart[i]['id'] == id){
        if(condition == 'up'){
          decodeCart[i]['qty']++; 
        } else if(condition == 'down') {
          if(decodeCart[i]['qty']-1 == 0){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Alert'),
                  content: Text('Qty Product Not Null')
                );
              }
            );
          } else {
            decodeCart[i]['qty']--;
          }
        }
      }
    }
    Session.setPrefs('cart', json.encode(decodeCart));
    initialization();
  }

  alertDelete(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Are You Sure Delete Product In Cart ?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () => deleteOneCart(id),
            )
          ],
        );
      }
    );
  }

  deleteOneCart(int id) async {
    var decodeCart = json.decode(await Session.getPrefs('cart'));
    var tampung = [];
    for (var i = 0; i < decodeCart.length; i++) {
      if(decodeCart[i]['id'] != id){
        tampung.add(decodeCart[i]);
      }
    }
    Session.setPrefs('cart', json.encode(tampung));
    initialization();
    Navigator.of(context).pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang')
      ),
      body: ListView.builder(
        itemCount: listKeranjang.length,
        itemBuilder: (context, index){
          return SizedBox(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network(Env.URL_IMAGE+listKeranjang[index]['image'], width: 80.0, height: 80.0),
                    title: Text(listKeranjang[index]['name']),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text('Size:'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(listKeranjang[index]['size'], style: TextStyle(color: Colors.red)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 8.0, 8.0, 8.0),
                              child: Text('Warna:'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(listKeranjang[index]['color'], style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${listKeranjang[index]['price']}",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Column(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: () { changeJumlah('up',listKeranjang[index]['id']); }),
                        Text(listKeranjang[index]['qty'].toString()),
                        IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){ changeJumlah('down',listKeranjang[index]['id']); })
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){
                            alertDelete(listKeranjang[index]['id']);
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          // elevation: 0.2,
                          child: Text('Delete')
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: Text('Total'),
              subtitle: Text('${totalCart}'),
            )),
            Expanded(child: MaterialButton(onPressed: (){},
              child: Text('Checkout',style: TextStyle(color: Colors.white),),
              color: Colors.red,
            ))
          ],
        ),
      ),
    );
  }
}

