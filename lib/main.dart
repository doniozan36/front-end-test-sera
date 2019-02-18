import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mobile_flutter/details.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> dataBarang = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var data = 
    getHttp();
  }

  @override
  Widget build(BuildContext context) {
      final title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: dataBarang.length,
          itemBuilder: (context,position){
            return ListTile(
              title: Text(dataBarang[position]["name"]),
              subtitle: Text(dataBarang[position]["email"]),
              onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detail(name: dataBarang[position]["name"],email: dataBarang[position]["email"])),
              )     
              // leading: Image.network("http://api-pos-market.club/${dataBarang[position]["image"]}"),
            );
          },
        )
      ),
    );
  }

  getHttp() async {
    try {
      Response response;
      response = await Dio().get("http://api-pos-market.club/api/customer/notoken");
      var data = response.data['data'];
      // print(data);
      for (int i = 0; i < data.length; i++) {
        setState(() {
          // print(data[i]);
          dataBarang.add(data[i]); 
        });
      }
      return print(dataBarang);
    } catch (e) {
      return print(e);
    }
  }
}