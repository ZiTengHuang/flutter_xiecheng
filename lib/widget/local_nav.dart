import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class LocalNav extends StatelessWidget {
  final List<LocalNavList> localNavModel;

  const LocalNav({Key key, @required this.localNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.all(7),
      height: 67,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavModel == null) return null;
    List<Widget> items = [];
    localNavModel.forEach((val) {
      items.add(_item(context, val));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, LocalNavList val) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: val.url,
                      statusBarColor: val.statusBarColor,
                      hideAppbar: val.hideAppBar,
                    )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            val.icon,
            height: 32,
            width: 32,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            val.title,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
