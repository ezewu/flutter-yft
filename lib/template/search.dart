import 'package:flutter/material.dart';
import '../config/fonts.dart';

Widget search() {
  return InkWell(
    onTap: () {
      print('点了的');
    },
    splashColor: Color(0xffffffff),
    child: Container(
      margin: EdgeInsets.all(8.0),
      child: Container(
        color: Color(0xfff1f1f1),
        height: 32.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              YftIcons.search,
              size: 13.0,
              color: Color(0xff666666),
            ),
            Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Text(
                '买房 卖房 就上广电云房通',
                style: TextStyle(color: Color(0xff666666), fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
