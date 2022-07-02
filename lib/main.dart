import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/custom_route_list.dart';
import 'html/fake_html.dart' if (dart.library.html) 'html/real_html.dart'
    as html;
import 'inherited_test.dart';
import 'provider_test.dart';
import 'riverpod/river_pod_page.dart';
import 'riverpod/riverpod.dart';
import 'web_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/': (context) => const MyHomePage(),
          CounterPage.route: (context) => const CounterPage(),
          WebPage.route: (context) => const WebPage(),
          ProviderPage.route: (context) => const ProviderPage(),
          ...riverpods,
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final List<RouteListItem> _items = const [
    RouteListItem(title: "InheritedWidget", route: CounterPage.route),
    RouteListItem(title: 'Provider', route: ProviderPage.route),
    RouteListItem(title: 'RiverPod', route: RiverPodPage.route),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter 状态管理"),
        actions: [
          _webAction(context),
        ],
      ),
      body: CustomRouteList(items: _items),
    );
  }

  Widget _webAction(BuildContext context) {
    return IconButton(
      onPressed: () => _openWeb(context),
      icon: const Icon(
        Icons.web_stories,
        color: Colors.white,
      ),
    );
  }

  void _openWeb(BuildContext context) {
    const url = 'https://note.youdao.com/s/6ynAn0Yq';
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else {
      Navigator.of(context).pushNamed(
        WebPage.route,
        arguments: const WebPageParams(url: url),
      );
    }
  }
}
