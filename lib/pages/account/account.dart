import 'package:flutter/material.dart';
import './login.dart';
import '../../resources/session.dart';
import './profile.dart';

class Account extends StatefulWidget {
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    await getToken();
  }

  Future<String> getToken()async{
    return this.token = await Session.getPrefs("token");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getToken(),
      builder: (BuildContext ctx, AsyncSnapshot snapshoot){
        if(this.token != ''){
          return Profile();
        }else{
          return Login();
        }
        return CircularProgressIndicator();
      }
    );
  }
}
