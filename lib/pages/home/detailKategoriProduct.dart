import 'package:flutter/material.dart';
import '../../resources/environment.dart';
import './detailProduct.dart';

class DetailKategoriProduct extends StatefulWidget {
  final kategori;
  final listBarang;

  DetailKategoriProduct({
    this.listBarang,
    this.kategori
  });
  _DetailKategoriProductState createState() => _DetailKategoriProductState();
}

class _DetailKategoriProductState extends State<DetailKategoriProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori '+widget.kategori),
      ),
      body: Container(
        // height: 460.0,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: widget.listBarang.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index){
            return ListProduct(
              detailProduct: widget.listBarang[index]
            );
          },
        ),
      )
    );
  }
}

class ListProduct extends StatelessWidget {
  final detailProduct;

  ListProduct({
    this.detailProduct
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: this.detailProduct['namaBarang'],
        child: Material(
          child: InkWell(
            onTap: () =>
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => 
                  DetailProduct(
                    product:this.detailProduct
                  )
              ) 
            ),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    this.detailProduct['namaBarang'],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),  
                  ),
                  title: Text(
                    this.detailProduct['hargaBarang'].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.red, fontWeight:FontWeight.w800),  
                  ),
                  
                ),
              ),
              child: Image.network(
                Env.URL_IMAGE+this.detailProduct['gambarBarang'],
                fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ),
    );
  }
}