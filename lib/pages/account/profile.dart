import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../resources/environment.dart';
import '../../resources/session.dart';
import './editProfile.dart';
import '../../main.dart';
import './changePassword.dart';

class Profile extends StatefulWidget {
  final Widget child;
  Profile({Key key, this.child}) : super(key: key);
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id = '';
  String token = '';
  dynamic profile;
  String imageProfile = 'http://vollrath.com/ClientCss/images/VollrathImages/No_Image_Available.jpg';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  initialization() async {
    this.id     = await Session.getPrefs('id');
    this.token  = await Session.getPrefs('token');
    await getProfile();
  }

  doLogout(){
    Session.setPrefs('id', '');
    Session.setPrefs('token', '');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp()
      ) 
    );
  }

  Future getProfile() async {
    try {
      Response response;
      var url = Env.API_URL+'user/'+this.id+'?token='+this.token;
      response = await Dio().get(url);
      var data =response.data['data'];
      if(data!=null){
        setState(() {
          this.profile = data;
          this.imageProfile = Env.URL_IMAGE+this.profile['image']; 
        });
      } else {
        doLogout();
      }
    } catch (e) {      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
            this.imageProfile,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Edit Profile'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                  EditProfile(
                    profile: this.profile,
                  )
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Ubah Password'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                  ChangePassword(
                    id: this.profile['id'],
                  )
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => doLogout(),
          ),
        ],
      )
    );
  }
}