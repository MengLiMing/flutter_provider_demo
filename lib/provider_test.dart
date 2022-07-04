import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final countModel1 = CountModel1();
  final countModel3 = CountModel3();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CountModel(),
        ),
        Provider.value(
          value: countModel1,
          updateShouldNotify: (old, n) => true,
        ),
        ProxyProvider0<CountModel2>(
          create: (context) => CountModel2(),
          update: (context, model) {
            return CountModel2()..count = model?.count ?? 0;
          },
        ),
        ListenableProvider(
          create: (context) => CountNotifier(),
        ),
        ListenableProvider.value(
          value: CountNotifier1(),
        ),
        FutureProvider<CountModel3>(
          create: (context) => Future.delayed(
              const Duration(seconds: 2), () => countModel3..count = 4),
          initialData: countModel3,
          updateShouldNotify: (c1, c2) => true,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// 下方这样写就是 分割一下 没什么必要
                    ...[
                      const CountWidget<CountModel>(),
                      _button('Provider - 点击+1', _valueAddition<CountModel>),
                    ],
                    ...[
                      const CountWidget<CountModel1>(),
                      _button(
                          'Provider.value - 点击+1', _valueAddition<CountModel1>),
                    ],
                    ...[
                      const CountWidget<CountModel2>(),
                      _button(
                          'ProxyProvider0 - 点击+1', _valueAddition<CountModel2>),
                    ],
                    ...[
                      const CountWidget<CountModel3>(),
                      _button(
                          'FutureProvider - 点击+1', _valueAddition<CountModel3>),
                    ],
                    ...[
                      const CountNotifierWidget<CountNotifier>(),
                      _button('ListenableProvider - 点击+1',
                          _countNotifierChanged<CountNotifier>),
                    ],
                    ...[
                      const CountNotifierWidget<CountNotifier1>(),
                      _button('ListenableProvider.value - 点击+1',
                          _countNotifierChanged<CountNotifier1>),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _valueAddition<T extends CountProvider>(BuildContext context) {
    setState(() {
      final model = context.read<T>();
      model.count += 1;
    });
  }

  void _countNotifierChanged<T extends CountNotifierProvider>(
      BuildContext context) {
    context.read<T>().count += 1;
  }

  Widget _button(String title, void Function(BuildContext conten) action) {
    return Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () => action(context),
          child: Text(title),
        );
      },
    );
  }
}

/// Provider
class CountWidget<T extends CountProvider> extends StatelessWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (context, model, child) {
      return Text('${model.count}');
    });
  }
}

abstract class CountProvider {
  int count = 0;
}

class CountModel extends CountProvider {}

class CountModel1 extends CountProvider {}

class CountModel2 extends CountProvider {}

class CountModel3 extends CountProvider {}

/// ChangeNotifierProvider
class CountNotifierWidget<T extends CountNotifierProvider>
    extends StatelessWidget {
  const CountNotifierWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
        builder: (context, value, child) => Text('${value.count}'));
  }
}

abstract class CountNotifierProvider extends ChangeNotifier with CountProvider {
  int _count = 0;

  @override
  int get count => _count;

  @override
  set count(int value) {
    _count = value;
    notifyListeners();
  }
}

class CountNotifier extends CountNotifierProvider {}

class CountNotifier1 extends CountNotifierProvider {}
