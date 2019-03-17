import 'package:flutter/material.dart';
import 'dart:convert';
import '../../resources/environment.dart';
import '../../resources/session.dart';

class Keranjang extends StatefulWidget {
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  List<dynamic> listKeranjang = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    await getCart();
  }

  Future getCart() async {
    var cart = await Session.getPrefs('cart');
    if(cart != null){
      var cartDecode = json.decode(cart);
      setState(() {
        for (var i = 0; i < cartDecode.length; i++) {
          listKeranjang.add(cartDecode[i]);
        }
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    print(listKeranjang);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang')
      ),
      body: ListView.builder(
        itemCount: listKeranjang.length,
        itemBuilder: (context, index){
          return ListProduct(
            nama_product: listKeranjang[index]['name'],
            gambar_product: Env.URL_IMAGE+listKeranjang[index]['image'],
            harga_product: listKeranjang[index]['price'],
            size: listKeranjang[index]['size'],
            warna: listKeranjang[index]['color'],
            jumlah: listKeranjang[index]['qty']
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: Text('data'),
              subtitle: Text('23232'),
            )),
            Expanded(child: MaterialButton(onPressed: (){},
              child: Text('data',style: TextStyle(color: Colors.white),),
              color: Colors.red,
            ))
          ],
        ),
      ),
    );
  }
}

class ListProduct extends StatelessWidget {
  final nama_product;
  final gambar_product;
  final harga_product;
  final size;
  final warna;
  final jumlah;

  ListProduct({
    this.gambar_product,
    this.harga_product,
    this.nama_product,
    this.jumlah,
    this.size,
    this.warna
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    // height: 160,
    child: Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(gambar_product, width: 80.0, height: 80.0),
            title: Text(nama_product),
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
                      child: Text(size, style: TextStyle(color: Colors.red)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 8.0, 8.0),
                      child: Text('Warna:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(warna, style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$harga_product",
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
                IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: (){}),
                Text(this.jumlah.toString()),
                IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){})
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Edit')
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  // elevation: 0.2,
                  child: Text('Hapus')
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
    // return Card(
    //   child: ListTile(
    //     leading: Image.network(gambar_product, width: 80.0, height: 80.0),
    //     title: Text(nama_product),
    //     subtitle: Column(
    //       children: <Widget>[
    //         Row(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.all(0.0),
    //               child: Text('Size:'),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(4.0),
    //               child: Text(size, style: TextStyle(color: Colors.red)),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
    //               child: Text('Warna:'),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(4.0),
    //               child: Text(warna, style: TextStyle(color: Colors.red)),
    //             ),
    //           ],
    //         ),
    //         Container(
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             "$harga_product",
    //             style: TextStyle(
    //               fontSize: 17.0,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.red
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}