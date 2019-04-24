import 'package:flutter/material.dart';

String imgUrl = 'http://www.devio.org/img/avatar.png';

class FlutterLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('小样式demo'),
           //gesture 监听手势
           leading: GestureDetector(
              onTap: (){
                  //退出界面
                  Navigator.pop(context);
              },
             child: Icon(Icons.close),
           ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  qQ(),
                  SizedBox(
                    width: 20,
                  ),
                  wW(),
                  SizedBox(
                    width: 20,
                  ),
                  tT(),
                ],
              ),
              eE(),
              rR(),
              uU(),
              iI(),
            ],
          ),
        ),
      ),
    );
  }
}

///圆形组件,将布局裁剪成圆形的组件
Widget qQ() {
  return ClipOval(
      child: SizedBox(
    width: 100,
    height: 100,
    child: Image.network(
      imgUrl,
    ),
  ));
}

///圆角矩形组件，//百分之60透明度
Widget wW() {
  return ClipRRect(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),

    ///透明度
    child: Opacity(
      opacity: 0.6,
      child: Image.network(
        imgUrl,
        width: 100,
        height: 100,
      ),
    ),
  );
}

/// 将布局显示成不同形状的组件
Widget eE() {
  return Container(
    height: 100,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.lightGreen),
    child: PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: PageView(
        children: <Widget>[
          _item(Colors.pink),
          _item(Colors.amber),
          _item(Colors.blueAccent),
        ],
      ),
    ),
  );
}

_item(Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
    ),
    child: Text('page'),
  );
}

/// 将宽度撑满整个布局
Widget rR() {
  return FractionallySizedBox(
    widthFactor: 0.5, //主要设置   1 为全满 其他按比例，会默认居中内容不居中 加alignment
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Text('66666666'),
    ),
  );
}

/// 叠加的小部件
Widget tT() {
  return Stack(
    children: <Widget>[
      Image.network(
        imgUrl,
        width: 100,
        height: 100,
      ),
      Positioned(
        left: 0,
        bottom: 0,
        child: Image.network(
          imgUrl,
          width: 30,
          height: 30,
        ),
      )
    ],
  );
}

///横向能自动换行的小部件warp
Widget uU() {
  return Wrap(
    spacing: 8, //水平间距
    runSpacing: 6, //垂直间距
    children: <Widget>[
      yY('黄紫腾'),
      yY('君君猪'),
      yY('君君猪'),
      yY('君君猪'),
      yY('君君猪'),

      /// 加一条线 、、
      Divider(
        color: Colors.grey,
        height: 1,
      )
    ],
  );
}

///小标签
Widget yY(String lable) {
  return Chip(
    label: Text(lable),
    //设置左边圆形的小图标
    avatar: CircleAvatar(
      backgroundColor: Colors.lightGreen[10],
      child: Text(
        lable.substring(0, 1),
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  );
}

///撑满父容器 可用宽或者高，
Widget iI() {
  return Expanded(
      child: Container(
    decoration: BoxDecoration(color: Colors.red),
    child: Text('asdfsadf'),
  ));
}
