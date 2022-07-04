import 'package:flutter/material.dart';

import '/common/custom_route_list.dart';

class RiverPodPage extends StatelessWidget {
  static const List<RouteListItem> _items = [
    RouteListItem(title: 'Provider', route: 'providerTest'),
    RouteListItem(title: 'StateProvider', route: '/stateProvider'),
    RouteListItem(
        title: 'StateNotifierProvider', route: '/stateNotifierProvider'),
    RouteListItem(title: 'FutureProvider', route: '/futureProvider'),
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
