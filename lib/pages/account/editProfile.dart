import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../resources/environment.dart';
import '../../main.dart';
import '../../resources/session.dart';

class EditProfile extends StatefulWidget {
  final profile;

  EditProfile({
    this.profile
  });
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerName     = TextEditingController();  
  TextEditingController controllerEmail    = TextEditingController();
  TextEditingController controllerAddress  = TextEditingController();
  TextEditingController controllerNoTelp   = TextEditingController();
  TextEditingController controllerIsActive = TextEditingController();
  TextEditingController controllerStatus   = TextEditingController();
  String id = '';
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    controllerName.text       = widget.profile['name'];
    controllerEmail.text      = widget.profile['email'];
    controllerAddress.text    = widget.profile['address'];
    controllerNoTelp.text     = widget.profile['no_telp'];
    controllerIsActive.text   = widget.profile['is_active'];
    controllerStatus.text     = widget.profile['status'];
    this.id                   = await Session.getPrefs('id');
    this.token                = await Session.getPrefs('token');
  }

  Future doEdit()async{
    // print(url);
    // print(controllerName.text);
    try {
      Response response;
      response = await Dio().post(Env.API_URL+"user/"+this.id+"?token="+this.token,
        data:{
          'email'    : controllerEmail.text,
          'name'     : controllerName.text,
          'no_telp'  : controllerNoTelp.text,
          'address'  : controllerAddress.text,
          'is_active': controllerIsActive.text,
          'status'   : controllerStatus.text
      });
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Berhasil Edit :)'),
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
            content: Text('Gagal Mengedit'),
          );
        }
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20.0),), 
          TextField(
            controller: controllerName,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0),), 
          TextField(
            controller: controllerEmail,
            decoration: InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          TextField(
            controller: controllerAddress,
            decoration: InputDecoration(
              hintText: 'Address',
              labelText: 'Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          TextField(
            controller: controllerNoTelp,
            decoration: InputDecoration(
              hintText: 'No Telp',
              labelText: 'No Telp',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          InkWell(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(child: Text('Edit', style: TextStyle(fontSize: 18.0,color: Colors.white),),),
            ),
            onTap: (){doEdit();},
          )
        ],
    ),
    );
  }
}