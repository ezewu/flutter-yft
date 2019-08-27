import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/fonts.dart';
import '../../template/title.dart';
import '../../template/item.dart';

import '../xinfangPage/xinfangPage.dart';
import '../ershouPage/ershouPage.dart';
import '../chuzuPage/chuzuPage.dart';
import '../demandsPage/demandsPage.dart';

import '../brokerPage/brokerPage.dart';
import '../calculatorPage/calculatorPage.dart';
import '../memberPage/memberPage.dart';
import '../mePage/mePage.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  List home = [];
  int userCount;
  int look;
  List itemData = [];

  @override
  void initState() {
    super.initState();
    getDataBase();
  }

  Future getDataBase() async {
    Dio dio = new Dio();
    Response response = await dio.get('https://yftapp.yunfangbao.org/api/home');
    if (response.statusCode == 200) {
      setState(() {
        home = response.data['data']['home']['img_name'];
        userCount = response.data['data']['user_count'];
        look = response.data['data']['home']['look'];
        itemData = response.data['data']['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return indexBody(home);
  }

  Widget indexBody(List home) {
    if (home.length == 0) {
      return SpinKitThreeBounce(
        color: Colors.blue,
        size: 30.0,
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            height: 180.0,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  'http://yftapp.deyou360.com/${home[index]}',
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: home.length,
              pagination: SwiperPagination(),
            ),
          ),
          Container(
            height: 40.0,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '圆您安居梦',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '平台浏览',
                      style: TextStyle(fontSize: 10.0, color: Colors.black87),
                    ),
                    Text(
                      look.toString(),
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '平台注册会员',
                      style: TextStyle(fontSize: 10.0, color: Colors.black87),
                    ),
                    Text(userCount.toString(),
                        style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1.0),
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    item(context, YftIcons.xinfang, 0xff2a62ad, '新房',
                        XinfangPage()),
                    item(context, YftIcons.ershoufang, 0xff49b140, '二手房',
                        ErshouPage()),
                    item(context, YftIcons.zufang, 0xffbec41c, '租房',
                        ChuzuPage()),
                    item(context, YftIcons.fangwumaimai, 0xffe30083, '需求发布',
                        DemandsPage())
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      item(context, YftIcons.baobei, 0xffc82226, '经纪人',
                          BrokerPage()),
                      item(context, YftIcons.suanfangdai, 0xff7590c7, '算房贷',
                          CalculatorPage()),
                      item(context, YftIcons.fangchanzhuanjia, 0xffacce22,
                          '合作会员', MemberPage()),
                      item(context, YftIcons.shouchang, 0xffeb6623, '个人中心',
                          MePage())
                    ],
                  ),
                )
              ],
            ),
          ),
          TipTitle('推荐楼盘'),
          ItemContent(itemData)
        ],
      );
    }
  }
}

Widget item(
    BuildContext context, IconData icon, int iconColor, String text, newPage,
    [int textColor = 0xff666666]) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return newPage;
          },
        ),
      );
    },
    splashColor: Color(0xffffffff),
    child: Column(
      children: <Widget>[
        Icon(icon, size: 45.0, color: Color(iconColor)),
        Text(
          text,
          style: TextStyle(fontSize: 12.0, color: Color(textColor)),
        )
      ],
    ),
  );
}
