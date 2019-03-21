import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/environment.dart';
import '../../resources/session.dart';
import '../../main.dart';

class Login extends StatefulWidget {

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  Future doLogin()async{
    try {
      Response response;
      response = await Dio().post(Env.API_URL+"auth/login",
        data:{
          'email'    : email,
          'password' : password
        });
      Session.setPrefs('id', response.data[0]['id'].toString());
      Session.setPrefs('token', response.data[0]['token']);
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Berhasil Login, Silahkan Berbelanja :)'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ya'),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp()
                  ) 
                ),
              )
            ],
          );
        }
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Salah Email/Password'),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)), 
            TextField(
              onChanged:(value) {
                setState(() {
                this.email = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)), 
            TextField(
              onChanged: (value) {
                setState(() {
                this.password = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            InkWell(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(child: Text('Login', style: TextStyle(fontSize: 18.0,color: Colors.white),),),
              ),
              onTap: (){doLogin();},
            )
          ],
      )
    );
  }
}