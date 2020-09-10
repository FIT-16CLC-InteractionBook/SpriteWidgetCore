import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IBCode extends StatefulWidget {
  final String content;
  final String theme;
  final String mode;

  IBCode(this.content, this.theme, this.mode) : super();
  @override
  _IBCodeState createState() => _IBCodeState(content, theme, mode);
}

class _IBCodeState extends State<IBCode> with AutomaticKeepAliveClientMixin {
  String content;
  String theme;
  String mode;
  InAppWebViewController _controller;

  _IBCodeState(_content, _theme, _mode) : super() {
    content = _content;
    theme = _theme;
    mode = _mode;
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialFile: 'assets/Codemirror.html',
      gestureRecognizers: [Factory(() => EagerGestureRecognizer())].toSet(),
      onWebViewCreated: (controller) {
        _controller = controller;
      },
      onLoadStop: (controller, url) async {
        String cTheme = theme;
        String cData = Uri.encodeFull(content);
        String cMode = mode;
        await controller.evaluateJavascript(
            source:
                "window.localStorage.setItem('content', '$cData'); window.localStorage.setItem('theme', '$cTheme'); window.localStorage.setItem('mode', '$cMode');");
        await _controller.evaluateJavascript(
          source:
              'window.dispatchEvent(new CustomEvent("native.code_mirror_execute"))',
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
