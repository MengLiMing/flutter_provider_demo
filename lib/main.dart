import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/inherited_test.dart';
import 'package:flutter_provider_demo/provider_test.dart';
import 'package:flutter_provider_demo/web_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const MyHomePage(),
        CounterPage.route: (context) => const CounterPage(),
        WebPage.route: (context) => const WebPage(),
        ProviderPage.route: (context) => const ProviderPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<HomeListItem> _items = const [
    HomeListItem(title: "InheritedWidget", route: CounterPage.route),
    HomeListItem(title: 'Provider', route: ProviderPage.route),
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
      body: ListView.separated(
        itemBuilder: _listItem,
        separatorBuilder: _sepetatorBuilder,
        itemCount: _items.length,
      ),
    );
  }

  Widget _webAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          WebPage.route,
          arguments:
              const WebPageParams(url: 'https://note.youdao.com/s/6ynAn0Yq'),
        );
      },
      icon: const Icon(
        Icons.details,
        color: Colors.white,
      ),
    );
  }

  Widget _listItem(BuildContext context, int index) {
    final item = _items[index];
    return ListTile(
      onTap: () => _onTap(context, item),
      title: Text(item.title),
    );
  }

  void _onTap(BuildContext context, HomeListItem item) {
    Navigator.of(context).pushNamed(item.route);
  }

  Widget _sepetatorBuilder(BuildContext context, int index) {
    return Divider(
      color: Colors.green.withOpacity(0.5),
      height: 0.5,
    );
  }
}

class HomeListItem {
  final String title;
  final String route;

  const HomeListItem({
    required this.title,
    required this.route,
  });
}
