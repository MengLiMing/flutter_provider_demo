import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderPage extends StatefulWidget {
  static const route = '/provider';

  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final countModel = CountModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(
        //   create: (context) => CountModel(),
        // ),
        Provider.value(
          value: CountModel(),
          updateShouldNotify: (old, n) => true,
        ),
        ChangeNotifierProvider(
          create: (context) => CountNotifier(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider'),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CountWidget(),
            _providerAddBtn(),
            const CountNotifierWidget(),
            _providerNotifyAddBtn(),
          ],
        )),
      ),
    );
  }

  Widget _providerAddBtn() {
    return Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () => _addition(context),
          child: const Text('Provider - 点击+1'),
        );
      },
    );
  }

  void _addition(BuildContext context) {
    setState(() {
      final model = context.read<CountModel>();
      model.count += 1;
    });
  }

  Widget _providerNotifyAddBtn() {
    return Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () => context.read<CountNotifier>().count += 1,
          child: const Text('NotifierProvider - 点击+1'),
        );
      },
    );
  }
}

/// Provider
class CountWidget extends StatelessWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(builder: (context, model, child) {
      return Text('${model.count}');
    });
  }
}

class CountModel {
  int count = 0;

  CountModel() {
    print('CountModel');
  }
}

/// ChangeNotifierProvider
class CountNotifierWidget extends StatelessWidget {
  const CountNotifierWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountNotifier>(
        builder: (context, value, child) => Text('${value.count}'));
  }
}

class CountNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count;
  set count(int value) {
    _count = value;
    notifyListeners();
  }
}
