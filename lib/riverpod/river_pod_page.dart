import 'package:flutter/material.dart';

import '/common/custom_route_list.dart';
import 'future_provider_test.dart';
import 'provider_test.dart';
import 'state_notifier_test.dart';
import 'state_provider_test.dart';

class RiverPodPage extends StatelessWidget {
  static const route = '/riverPod';

  static const List<RouteListItem> _items = [
    RouteListItem(title: 'Provider', route: RiverProviderTestPage.route),
    RouteListItem(title: 'StateProvider', route: StateProviderTestPage.route),
    RouteListItem(
        title: 'StateNotifierProvider',
        route: StateNotifierProviderTestPage.route),
    RouteListItem(title: 'FutureProvider', route: FutureProviderTestPage.route),
  ];

  const RiverPodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiverPod'),
      ),
      body: const CustomRouteList(
        items: _items,
      ),
    );
  }
}
