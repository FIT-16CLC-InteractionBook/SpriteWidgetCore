import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
    return InAppWebView(
      initialUrl: Uri.encodeFull(
          "https://ibcoding.netlify.app/interactive-book-codemirror/mode=$type&&&&theme=$theme&&&&content=$data"),
    );
  }
}
