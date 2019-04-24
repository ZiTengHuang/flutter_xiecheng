import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/page/index_page.dart';
import 'package:flutter_xiecheng/page/my_page.dart';
import 'package:flutter_xiecheng/page/search_page.dart';
import 'package:flutter_xiecheng/page/travel_page.dart';

class FlutterHome extends StatefulWidget {
  _FlutterHomeState createState() => _FlutterHomeState();
}

class _FlutterHomeState extends State<FlutterHome> {
  final PageController _controller = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[IndexPage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
           icon: Icon(Icons.home,)
        ),

      ]),
    );
  }
}
