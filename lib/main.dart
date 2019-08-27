import 'package:flutter/material.dart';
import 'sortItem/indexPage/indexPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '广电云房通',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: Colors.white, //原色
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexPage(),
    );
  }
}
