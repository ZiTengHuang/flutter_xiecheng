import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
      this.backForbid})
      : super(key: key);

  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {


  final webviewReference = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///防止界面重新打开
    webviewReference.close();
    ///界面url发生改变可以监听它
    webviewReference.onUrlChanged.listen((String url){

    });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
