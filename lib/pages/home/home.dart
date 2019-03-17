import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import './detailProduct.dart';
import './detailKategoriProduct.dart';
import 'package:dio/dio.dart';
import '../../resources/environment.dart';
import '../../resources/session.dart';

class Home extends StatefulWidget {

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<dynamic> listProductTerpopuler = [];
  List<dynamic> listKategori = [];
  List<dynamic> listBanner = [];

  @override
  void initState() {
    super.initState();
    initialization();
  }

  initialization()async{
    await getListKategori();
    await getListProductTerpopuler();
    await getBanner();
  }

  Future getBanner() async {
    Session.setPrefs('cart', null);
    try {
      Response response;
      response =await Dio().get(Env.API_URL+"banner/no-token");
      var data =response.data['data'];
      if(data!=null){
        setState(() {
          for (var i = 0; i < data.length; i++) {
            listBanner.add(NetworkImage(Env.URL_IMAGE+data[i]['gambar_banner']));
          }
        });
      }
    } catch (e) {
    }
  }

  Future getListKategori() async {
    try {
      Response response;
      response =await Dio().get(Env.API_URL+"kategori-barang/no-token");
      var data = response.data['data'];
      if(data != null){
        setState(() {
          for(int i = 0; i<data.length; i++){
            listKategori.add(data[i]);
          }  
        });
      }
    } catch (e) {
      return print(e);
    }
  }

  Future getListProductTerpopuler() async {
    try {
      Response response;
      response = await Dio().get(Env.API_URL+"barang-terbaru/no-token");
      var data = response.data['data'];
      if(data != null){
        setState(() {
          for(int i = 0; i<data.length; i++){
            listProductTerpopuler.add(data[i]);
          }  
        });
      }
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget image_corousel = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images:listBanner,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        dotSize: 3.0,
        animationDuration: Duration(milliseconds: 1000)
      ),
    );
    Icon actionIcon = new Icon(Icons.search);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          image_corousel,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Kategori'),
          ),
          Container(
            color: Colors.white,
            height: 80.0,
            child: listKategori.length>0 ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listKategori.length,
              itemBuilder: (BuildContext context, int index){
                return Kategori(
                  kategori: listKategori[index]
                );
              }
            ):Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('New Product'),
          ),
          //gridView
          Container(
            height: 360.0,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: listProductTerpopuler.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index){
                return ProductTerpopuler(
                  product:listProductTerpopuler[index]
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Kategori extends StatelessWidget {
  final kategori;


  Kategori({
    this.kategori
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () =>
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => 
                DetailKategoriProduct(
                  kategori: this.kategori['name'],
                  listBarang: this.kategori['barang']
                )
            ) 
          ),
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.network(
              Env.URL_IMAGE+this.kategori['gambarKategori'], 
              width: 80.0, 
              height: 50.0
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(this.kategori['name'], style: new TextStyle(fontSize: 12.0)),
            ),
          ),
        )
      ),
    );
  }
}

class ProductTerpopuler extends StatelessWidget {
  final product;

  ProductTerpopuler({
    this.product
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: this.product['namaBarang'],
        // this.product['namaBarang'],
        child: Material(
          child: InkWell(
            onTap: () =>
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => 
                  new DetailProduct(
                    product:this.product
                  )
              ) 
            ),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    // '',
                    this.product['namaBarang'],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),  
                  ),
                  title: Text(
                    // '',
                    this.product["hargaBarang"].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.red, fontWeight:FontWeight.w800),  
                  ),
                ),
              ),
              child: Image.network(
                Env.URL_IMAGE+this.product['gambarBarang'],
                fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ),
    );
  }
}