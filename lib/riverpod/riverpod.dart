import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/riverpod/river_pod_page.dart';

import 'future_provider_test.dart';
import 'provider_test.dart';
import 'river_pod_page.dart';
import 'state_notifier_test.dart';
import 'state_provider_test.dart';

Map<String, WidgetBuilder> riverpods = {
  RiverPodPage.route: (context) => const RiverPodPage(),
  RiverProviderTestPage.route: (context) => const RiverProviderTestPage(),
  StateProviderTestPage.route: (context) => const StateProviderTestPage(),
  StateNotifierProviderTestPage.route: (context) =>
      const StateNotifierProviderTestPage(),
  FutureProviderTestPage.route: (context) => const FutureProviderTestPage(),
};
