import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosNotifier extends StateNotifier<List<String>> {
  TodosNotifier(List<String> state) : super(state);

  void addTodo(String todo) {
    final old = [...state];
    old.add(todo);
    state = old;
  }

  void remove(String todo) {
    final old = [...state];
    old.remove(todo);
    state = old;
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<String>>(
    (ref) => TodosNotifier([]));

class StateNotifierProviderTestPage extends ConsumerStatefulWidget {
  const StateNotifierProviderTestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StateNotifierProviderTestPageState();
}

class _StateNotifierProviderTestPageState
    extends ConsumerState<StateNotifierProviderTestPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      ref.read(todosProvider.notifier)
        ..addTodo('哈哈哈哈哈')
        ..addTodo('哈哈哈哈哈1')
        ..addTodo('哈哈哈哈哈2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider'),
      ),
      body: const TodoListView(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(todosProvider);
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(list[index]),
        );
      },
      itemCount: list.length,
    );
  }
}
