import 'package:flutter/material.dart';

class TipTitle extends StatelessWidget {
  final String text;
  TipTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          height: 1.0,
        ),
        Row(
          children: <Widget>[
            Container(width: 5.0, height: 25.0, color: Color(0xff0069b4)),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                color: Color(0xfff5f7f9),
                child: Text(
                  text,
                  style: TextStyle(color: Color(0xff0069b4)),
                ),
              ),
            )
          ],
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}
