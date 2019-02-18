import 'package:flutter/material.dart';

class Detail extends StatelessWidget {

  String email;
  String name;
  Detail({this.email,this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("nama : ${this.name}"),
              Text("email : ${this.email}")
            ],
          ),
        ),
      )
    );
  }
}