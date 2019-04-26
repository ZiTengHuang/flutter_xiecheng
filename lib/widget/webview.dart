import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
];

class WebView extends StatefulWidget {
  final String url;

  final String statusBarColor;
  final String title;
  final bool hideAppbar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppbar,
      this.backForbid = false})
      : super(key: key);

  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///防止界面重新打开
    webviewReference.close();

    ///界面url发生改变可以监听它
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});

    ///页面导航的状态监听
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {

        ///监听开始加载的时候
        case WebViewState.startLoad:

          /// 如果包含我们规则的html 并且 第一次打开
          if (_isToMain(state.url) && !exiting) {
            ///如果back 会真，重新打开这个个界面
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            } else {
              ///否则退回
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      /// 这个? 表示这个url存在的情况下在执行后面的
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,

              ///   是否可以缩放
              withZoom: true,

              /// 是否缓存
              withLocalStorage: true,

              /// 是否可以隐藏
              hidden: true,

              /// 加载中上个代码设置为隐藏  这个步骤是在隐藏的过程中设置一个加载中的界面 目前是个bug
              initialChild: Container(
                color: Color(int.parse('0xff' + statusBarColorStr)),
                child: Center(
                  child: Text('Waiting....'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroudColor, Color backButtonColor) {
    if (widget.hideAppbar ?? false) {
      return Container(
        color: backgroudColor,
        height: 40,
      );
    }
    return Container(
      /// 这个布局可以设置方向的撑满整个布局
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: backgroudColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
