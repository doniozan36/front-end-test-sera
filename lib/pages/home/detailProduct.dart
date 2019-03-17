import 'package:flutter/material.dart';
import '../../resources/environment.dart';
import 'dart:convert';
import '../../resources/session.dart';

class DetailProduct extends StatefulWidget {
  final product;

  DetailProduct({
    this.product
  });
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  List<dynamic> listWarna = [];
  List<dynamic> listSize = [];
  List<dynamic> cart = [];
  String sizeValue  = 'Size';
  String warnaValue = 'Color';
  String qtyValue  = 'Qty';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    await getSizeToArray(widget.product['sizeBarang']);
    await getWarnaToArray(widget.product['warnaBarang']);
  }

  Future getSizeToArray(String size) async {
    this.listSize = size.split("|");
  }

  Future getWarnaToArray(String warna) async {
    this.listWarna = warna.split("|");
  }

  Future addToCart() async {
    if(this.sizeValue == 'Size' || this.warnaValue == 'Color' || this.qtyValue == 'Qty'){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Detail Data Not Null')
          );
        }
      );
    } else {
      var dataCart = await Session.getPrefs('cart');
      var checkProduct = 0;
      if(dataCart != null){
        cart = json.decode(dataCart);
        for (var i = 0; i < cart.length; i++) {
          if(cart[i]['id'] == widget.product['id']){
            checkProduct = 1;
            break;
          }
        }
      }
      if(checkProduct == 0){
        cart.add({
          'id'        : widget.product['id'],
          'name'      : widget.product['namaBarang'],
          'image'     : widget.product['gambarBarang'],
          'qty'       : int.parse(this.qtyValue),
          'size'      : this.sizeValue,
          'color'     : this.warnaValue,
          'price'     : widget.product['hargaBarang'],
          'updated_at': widget.product['updated_at']
        });
        var cartEncode = json.encode(cart);
        Session.setPrefs('cart', cartEncode);
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Success Add To Cart')
            );
          }
        );
        print(checkProduct);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Already Product')
            );
          }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Product '+widget.product['namaBarang']),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(Env.URL_IMAGE+widget.product['gambarBarang'])
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.product['namaBarang'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(widget.product['hargaBarang']),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('Size'),
                          content: ListView.builder(
                            itemCount: this.listSize.length,
                            itemBuilder: (BuildContext context, int index){
                              return ListTile(
                                title: Text(this.listSize[index]),
                                onTap: () {
                                  setState(() {
                                    this.sizeValue = this.listSize[index];
                                  });
                                  Navigator.of(context).pop(context);
                                },
                              );
                            }
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                              child: Text('back'),
                            )
                          ],
                        );
                      }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(this.sizeValue)
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('Color'),
                          content: ListView.builder(
                            itemCount: this.listWarna.length,
                            itemBuilder: (BuildContext context, int index){
                              return ListTile(
                                title: Text(this.listWarna[index]),
                                onTap: (){
                                  setState(() {
                                    this.warnaValue = this.listWarna[index];
                                  });
                                  Navigator.of(context).pop(context);
                                },
                              );
                            }
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                              child: Text('back'),
                            )
                          ],
                        );
                      }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(this.warnaValue)
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('Jumlah'),
                          content: ListView.builder(
                            itemCount: int.parse(widget.product['jumlahBarang']),
                            itemBuilder: (BuildContext contect, int index){
                              return ListTile(
                                title: Text((index+1).toString()),
                                onTap: (){
                                  setState(() {
                                    this.qtyValue = (index+1).toString();
                                  });
                                  Navigator.of(context).pop(context);
                                },
                              );
                            },
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                              child: Text('back'),
                            )
                          ],
                        );
                      }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(this.qtyValue)
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () => addToCart(),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text('Add To Cart'),
                ),
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text('Deskripsi Product'),
            subtitle: Text(widget.product['deskripsiBarang']),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              )
            ],
          )
        ],
      ),
    );
  }
}