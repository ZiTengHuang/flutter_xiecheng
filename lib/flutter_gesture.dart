import 'package:flutter/material.dart';

///flutter用户手势监听
class FlutterGesture extends StatefulWidget {
  _FlutterGestureState createState() => _FlutterGestureState();
}

class _FlutterGestureState extends State<FlutterGesture> {
  String printString = '';
  double moveX = 0;

  double moveY = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('手势的监听与处理'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.clear),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _printMsg('点击'),
                    onDoubleTap: () => _printMsg('双击'),
                    onLongPress: () => _printMsg('长按'),
                    onTapCancel: () => _printMsg('取消'),
                    onTapUp: (e) => _printMsg('松开'),
                    onTapDown: (e) => _printMsg('按下'),
                    child: Container(
                      padding: EdgeInsets.all(60),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      child: Text('点我'),
                    ),
                  ),
                  Text(printString),
                ],
              ),
              Positioned(
                left: moveX,
                top: moveY,
                child: GestureDetector(
                   onPanUpdate: (e) => _doMove(e),
                   child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                         color: Colors.yellow,
                         borderRadius: BorderRadius.circular(36),
                      ),
                   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _printMsg(String onTach) {
    setState(() {
      printString += ', ${onTach}';
    });
  }

  _doMove(DragUpdateDetails e) {
    setState(() {
        moveY += e.delta.dy;
        moveX += e.delta.dx;
    });
  }

}
