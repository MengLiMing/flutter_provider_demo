import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadProvider = FutureProvider.autoDispose((ref) {
  ref.onDispose(() {
    /// 可以在此处取消请求
    print('disposed');
  });
  return loadSomething();
});

Future<String> loadSomething() async {
  return Future.delayed(
    const Duration(seconds: 3),
    () {
      return 'something';
    },
  );
}

class FutureProviderTestPage extends ConsumerStatefulWidget {
  const FutureProviderTestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FutureProviderTestPageState();
}

class _FutureProviderTestPageState
    extends ConsumerState<FutureProviderTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider'),
        actions: [
          IconButton(
            onPressed: _pushSecondPage,
            icon: const Icon(Icons.next_plan),
          ),
        ],
      ),
      body: Center(
        child: ref.watch(loadProvider).when(
              data: (data) {
                return Text(data);
              },
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }

  void _pushSecondPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SecondPage(),
      ),
    );
  }
}

class SecondPage extends ConsumerWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ref.watch(loadProvider).when(
              data: (data) {
                return Text(data);
              },
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }
}
