import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateProvider((ref) => 0);

class StateProviderTestPage extends ConsumerWidget {
  static const route = '/stateProvider';

  const StateProviderTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: const Center(child: CountWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countProvider.state).state += 1;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Text(ref.watch(countProvider).toString());
        // return Text(ref.watch(countProvider.state).state.toString());
      },
    );
  }
}
