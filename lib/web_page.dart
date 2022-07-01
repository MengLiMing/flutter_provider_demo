import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageParams {
  final String url;

  const WebPageParams({required this.url});
}

class WebPage extends StatelessWidget {
  static const route = '/web';

  const WebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WebPageParams?;
    final String? url = args?.url;
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
