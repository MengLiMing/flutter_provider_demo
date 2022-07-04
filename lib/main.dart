import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/common/deffer_library_widget.dart';
import 'package:flutter_provider_demo/inherited_test.dart'
    deferred as inherited_test;
import 'package:flutter_provider_demo/provider_test.dart'
    deferred as provider_test;
import 'package:flutter_provider_demo/web_page.dart' deferred as web_page;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/custom_route_list.dart';
import 'html/fake_html.dart' if (dart.library.html) 'html/real_html.dart'
    as html;
import 'riverpod/riverpod.dart';

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
        routes: routes,
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
    RouteListItem(title: "InheritedWidget", route: '/inherited'),
    RouteListItem(title: 'Provider', route: '/provider'),
    RouteListItem(title: 'RiverPod', route: '/riverPod'),
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
        '/web',
        arguments: url,
      );
    }
  }
}

Map<String, WidgetBuilder> routes = {
  '/': (context) => const MyHomePage(),
  '/inherited': (context) => DefferLibraryWidget(
        libraryFuture: inherited_test.loadLibrary(),
        child: (context) {
          return inherited_test.CounterPage();
        },
      ),
  '/web': (context) => DefferLibraryWidget(
        libraryFuture: web_page.loadLibrary(),
        child: (context) {
          return web_page.WebPage();
        },
      ),
  '/provider': (context) => DefferLibraryWidget(
        libraryFuture: provider_test.loadLibrary(),
        child: (context) {
          return provider_test.ProviderPage();
        },
      ),
  ...riverpods,
};
