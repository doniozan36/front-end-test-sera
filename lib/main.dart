import 'package:flutter/material.dart';

import './pages/home/home.dart';
import './pages/keranjang/keranjang.dart';
import './pages/account/account.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {

  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _page = 0;
  int _currentIndex = 0;
  PageController _pageController = new PageController();
  void onPageChanged(int page){
    setState(() {
      this._page = page;
    });
  }

  navigationTapped(int page) async {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300), curve: Curves.ease
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: <Widget>[
            Home(),
            Keranjang(),
            Account()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home')
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart),
              title: new Text('Keranjang')
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              title: new Text('Akun'),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}