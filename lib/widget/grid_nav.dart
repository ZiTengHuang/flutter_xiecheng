import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

/// 网格卡片
class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GridNavWidget({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      ///是否裁切
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    ///如果酒店不为空
    if (gridNavModel.hotel != null) {
     items.add(_gridNavItem(context,gridNavModel,true));

    }
    ///机票不为空
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context,gridNavModel,false));

    }
    ///火车
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context,gridNavModel,false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNav mainItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavModel));
    items.add(_doubleItem(context, mainItem.travel.mainItem, mainItem));
    items.add(_doubleItem(context, mainItem.travel.mainItem, mainItem));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    Color startColor = Color(int.parse('0xff'+mainItem.hotel.startColor));
    Color endColor = Color(int.parse('0xff'+mainItem.hotel.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor]),
      ),
      child: Row(children:expandItems),
    );
  }

  _mainItem(BuildContext context, GridNav gridNavModel) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              gridNavModel.hotel.mainItem.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
               margin: EdgeInsets.only(top: 11),
              child:   Text(
                gridNavModel.hotel.mainItem.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        gridNavModel);
  }

  _doubleItem(
      BuildContext context, MainItem topMainModel, GridNav bottomMainModel) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, bottomMainModel, true),
        ),
        Expanded(
          child: _item(context, bottomMainModel, false),
        ),
      ],
    );
  }

  _item(BuildContext context, GridNav itme, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          )),
          child: _wrapGesture(
              context,
              Center(
                child: Text(
                  itme.hotel.item1.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              itme)),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, GridNav item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.hotel.mainItem.url,
                      statusBarColor: item.hotel.mainItem.statusBarColor,
                      title: item.hotel.mainItem.title,
                    )));
      },
      child: widget,
    );
  }
}
