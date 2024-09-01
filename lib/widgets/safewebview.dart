import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Safewebview extends StatelessWidget {
  final String url;

  Safewebview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
