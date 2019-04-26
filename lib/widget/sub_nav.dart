import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<SubNavList> subNavModel;

  const SubNav({Key key, @required this.subNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.all(7),
       decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavModel == null) return null;
    List<Widget> items = [];
    subNavModel.forEach((val) {
      items.add(_item(context, val));
    });

    ///计算第一行显示的数量
    int separate = (subNavModel.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, items.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, SubNavList val) {
    return Expanded(
       flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                    url: val.url,
                    hideAppbar: val.hideAppBar,
                  )));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              val.icon,
              height: 18,
              width: 18,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              val.title,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
