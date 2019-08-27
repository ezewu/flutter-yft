import 'package:flutter/material.dart';

import '../config/config.dart';
import '../config/label.dart';
import '../config/fonts.dart';

class ItemContent extends StatelessWidget {
  final List data;
  ItemContent(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(children: createItem(data)),
    );
  }

  List<Widget> createLabel(label) {
    List<Widget> newLabel = [];
    for (var i = 0; i < label.length; i++) {
      int idx = int.parse(label[i]) - 1;
      newLabel.add(
        Container(
          padding: EdgeInsets.only(right: 2.0, left: 2.0),
          margin: EdgeInsets.only(right: 2.0),
          color: Color.fromRGBO(
            Label.labelBgColor[idx][0],
            Label.labelBgColor[idx][1],
            Label.labelBgColor[idx][2],
            Label.labelBgColor[idx][3],
          ),
          child: Text(
            Label.labelText[idx],
            style: TextStyle(
              fontSize: 10.0,
              color: Color.fromRGBO(
                Label.labelTextColor[idx][0],
                Label.labelTextColor[idx][1],
                Label.labelTextColor[idx][2],
                Label.labelTextColor[idx][3],
              ),
            ),
          ),
        ),
      );
    }
    return newLabel;
  }

  Widget isShowMember(member, pm) {
    if (member == '') {
      return Text(
        '面积 $pm',
        style: TextStyle(
          fontSize: 13.0,
          color: Color(0xff666666),
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Icon(YftIcons.member, size: 14.0, color: Color(0xffff0000)),
          ),
          Text(
            member,
            style: TextStyle(fontSize: 14.0, color: Color(0xff666666)),
          )
        ],
      );
    }
  }

  List<Widget> createItem(data) {
    List<Widget> newItem = [];
    for (var i = 0; i < data.length; i++) {
      newItem.add(
        InkWell(
          onTap: () {
            print(data[i]['label']);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            height: 100.0,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.network('${Api.QINIU_URL}${data[i]['image'][0]}',
                            width: 124.0, height: 98.0, fit: BoxFit.cover),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(right: 2.0, left: 2.0),
                            color: Color.fromRGBO(7, 17, 27, 0.6),
                            child: Text(
                              data[i]['state'],
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                              ),
                            ),
                          ),
                          right: 0.0,
                          bottom: 0.0,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            data[i]['title'],
                            style: TextStyle(
                                fontSize: 15.0, color: Color(0xff333333)),
                          ),
                          Text(
                            data[i]['area'],
                            style: TextStyle(
                                fontSize: 13.0, color: Color(0xff666666)),
                          ),
                          isShowMember(data[i]['member'], data[i]['pm']),
                          Row(
                            children: createLabel(data[i]['label']),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '${data[i]['danjia']}',
                            style: TextStyle(
                                fontSize: 18.0, color: Color(0xffff0000))),
                        TextSpan(
                          text: data[i]['danjia'] == '待定' ? '' : '元/㎡',
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xffee0000)),
                        ),
                      ],
                    ),
                  ),
                  right: 0.0,
                  top: 24.0,
                ),
              ],
            ),
          ),
        ),
      );
      if (i < data.length - 1) {
        newItem.add(
          Divider(
            height: 1.0,
          ),
        );
      }
    }
    return newItem;
  }
}
