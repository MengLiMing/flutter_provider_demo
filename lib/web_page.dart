import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageParams {
  final String url;

  const WebPageParams({required this.url});
}

class WebPage extends StatelessWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? url = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web'),
      ),
      body: url == null
          ? const Center(
              child: Text('参数错误'),
            )
          : WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
            ),
    );
  }
}
