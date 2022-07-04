import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = Provider((ref) {
  return CountModel();
});

class RiverProviderTestPage extends ConsumerStatefulWidget {
  const RiverProviderTestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverProviderTestPage> createState() => _CountPageState();
}

class _CountPageState extends ConsumerState<RiverProviderTestPage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();

    _count = ref.read(countProvider).count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider()')),
      body: const Center(
        child: CountText(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _additation,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _additation() {
    ref.refresh(countProvider).count = _count += 1;
  }
}

class CountText extends StatelessWidget {
  const CountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, child) {
        return Text(ref.watch(countProvider).count.toString());
      },
    );
  }
}

class CountModel {
  int count = 0;
}
