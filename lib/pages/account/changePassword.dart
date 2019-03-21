import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../resources/session.dart';
import '../../resources/environment.dart';
import '../../main.dart';

class ChangePassword extends StatefulWidget {
  final id;
  ChangePassword({
    this.id
  });
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String password = '';
  String newPassword = '';
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    this.token =await Session.getPrefs('token');
  }

  Future doChangePassword() async {
    try {
      Response response;
      print(Env.API_URL+"user/change-password/"+widget.id.toString()+"?token="+this.token);
      response = await Dio().post(Env.API_URL+"user/change-password/"+widget.id.toString()+"?token="+this.token,
        data:{
          'password'    : password,
          'newPassword' : newPassword
        });
      var data = response.data;
      print(data);
      if(data['status'] == 200){
        Session.setPrefs('id', '');
        Session.setPrefs('token', '');
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Berhasil Ganti Password, Silahkan Login Kembali :)'),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Salah Password'),
            );
          }
        );
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20.0)),
          TextField(
            onChanged: (value){
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
            )
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          TextField(
            onChanged: (value){
              setState(() {
                this.newPassword = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'New Password',
              labelText: 'New Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            )
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
              child: Center(child: Text('Change Password', style: TextStyle(fontSize: 18.0,color: Colors.white),),),
            ),
            onTap: () => doChangePassword(),
          )
        ],
      ),
    );
  }
}