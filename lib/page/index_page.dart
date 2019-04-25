import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_xiecheng/service/service_method.dart';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List _imageUrls = [
    'http://image.biaobaiju.com/uploads/20180211/01/1518283483-ZSaWgidtGK.jpg',
    'http://image.biaobaiju.com/uploads/20180211/01/1518283483-KPEvBDMLHZ.jpg',
    'http://image.biaobaiju.com/uploads/20180211/01/1518283483-GhpAyjVbsW.jpg',
  ];
  double appBarAlpha = 0;
  List<LocalNavList> localNavList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xf2f2f2),
      body: Stack(
        children: <Widget>[
          ///MediaQuery.removePadding 移除listview内置的pading边距
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                ///滚动是0的时候也会触发所以要判断  scrollNotification.depth 判断他的深度，深度为第0个元素 就是listview
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  /// 滚动且是列表滚动的时候才触发 返回滚动的距离
                  _onSrcoll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 180,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  LocalNav(localNavModel: localNavList,),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _onSrcoll(double offset) {
    ///第一次打印时候发现不停的打印数值、其为监听了 子元素的的滚动  banner图
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    // print('==========>${appBarAlpha}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHomeModel();
  }

  void _getHomeModel() async {
    await requestGet('getHomePage').then((val) {
      //print(val);
      //  var data = json.decode(val.toString());
      HomeModel homeModel = HomeModel.fromJson(val);
//       print(homeModel.bannerList[0].icon);
//       print(homeModel.bannerList[1].icon);
//       print(homeModel.bannerList[2].icon);
//       print(homeModel.bannerList[3].icon);
      setState(() {
        localNavList = homeModel.localNavList;
      });
    });
  }
}
