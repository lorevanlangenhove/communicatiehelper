import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SymbolsPage extends StatefulWidget {
  @override
  State<SymbolsPage> createState() => _SymbolsPageState();
}

class _SymbolsPageState extends State<SymbolsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coughdrop'),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://app.mycoughdrop.com',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }
}
// https://app.mycoughdrop.com
// http://localhost:4200/
