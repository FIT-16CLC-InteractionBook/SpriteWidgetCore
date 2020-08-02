import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class IBCode extends StatefulWidget {
  final String dataCodeUrl;

  IBCode(this.dataCodeUrl) : super();
  @override
  _IBCodeState createState() => _IBCodeState(dataCodeUrl);
}

class _IBCodeState extends State<IBCode> {
  bool loading = false;
  String dataCodeUrl;
  WebViewController _controller;

  _IBCodeState(_dataCodeUrl) : super() {
    dataCodeUrl = _dataCodeUrl;
  }

  void _loadHtml() async {
    String contentHtml = await File(dataCodeUrl).readAsString();
    print(contentHtml);
    _controller.loadUrl(Uri.dataFromString(contentHtml,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: const CircularProgressIndicator())
        : WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              setState(() {
                loading = true;
              });
              _loadHtml();
            },
          );
  }
}
