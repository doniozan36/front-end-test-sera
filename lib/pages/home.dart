import 'package:flutter/material.dart';

import './register.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.network('https://ecs7.tokopedia.net/img/cache/215-square/shops-1/2018/1/17/2880590/2880590_9a70eac7-210e-4ede-955a-387497d9daea.png'),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text('Login'),
              
            ),
            ListTile(
              title: Text('Register'),
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) => Register()
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}