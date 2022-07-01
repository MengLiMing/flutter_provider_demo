import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  static const String route = '/counte';

  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidget'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CountWidget(
              count: _count,
              child: const CountText(),
            ),
            ElevatedButton(
              onPressed: _addition,
              child: const Text('点击+1'),
            ),
          ],
        ),
      ),
    );
  }

  void _addition() {
    setState(() {
      _count += 1;
    });
  }
}

class CountText extends StatelessWidget {
  const CountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int count = CountWidget.of(context, isDepend: true)?.count ?? 0;
    return Text(
      '$count',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.blue,
      ),
    );
  }
}

class CountWidget extends InheritedWidget {
  final int count;

  const CountWidget({
    Key? key,
    required this.count,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant CountWidget oldWidget) {
    return oldWidget.count != count;
  }

  static CountWidget? of(BuildContext context, {bool isDepend = true}) {
    if (isDepend) {
      return context.dependOnInheritedWidgetOfExactType<CountWidget>();
    } else {
      return context
          .getElementForInheritedWidgetOfExactType<CountWidget>()
          ?.widget as CountWidget;
    }
  }
}
