import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class WebViewScreen extends StatelessWidget {
  String url = 'https://maxsipconnects.com';
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WebViewX(
      width: size.width,
      height: size.height,
      initialContent: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) => webviewController = controller,
    );
  }
}
