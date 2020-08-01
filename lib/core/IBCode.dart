import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class IBCode extends StatefulWidget {
  final String data;
  final String theme;
  final String type;

  IBCode(this.data, this.theme, this.type) : super();
  @override
  _IBCodeState createState() => _IBCodeState(data, theme, type);
}

class _IBCodeState extends State<IBCode> {
  String data;
  String theme;
  String type;

  _IBCodeState(_data, _theme, _type) : super() {
    data = _data;
    theme = _theme;
    type = _type;
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://google.com",
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
    );
  }
}
