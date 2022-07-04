import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/common/deffer_library_widget.dart';
import 'package:flutter_provider_demo/riverpod/future_provider_test.dart'
    deferred as future_provider_test;
import 'package:flutter_provider_demo/riverpod/provider_test.dart'
    deferred as provider_test;
import 'package:flutter_provider_demo/riverpod/river_pod_page.dart'
    deferred as river_pod_page;
import 'package:flutter_provider_demo/riverpod/state_notifier_test.dart'
    deferred as state_notifier_test;
import 'package:flutter_provider_demo/riverpod/state_provider_test.dart'
    deferred as state_provider_test;

Map<String, WidgetBuilder> riverpods = {
  '/riverPod': (context) => DefferLibraryWidget(
        libraryFuture: river_pod_page.loadLibrary(),
        child: (context) {
          return river_pod_page.RiverPodPage();
        },
      ),
  '/providerTest': (context) => DefferLibraryWidget(
        libraryFuture: provider_test.loadLibrary(),
        child: (context) {
          return provider_test.RiverProviderTestPage();
        },
      ),
  '/stateProvider': (context) => DefferLibraryWidget(
        libraryFuture: state_provider_test.loadLibrary(),
        child: (context) {
          return state_provider_test.StateProviderTestPage();
        },
      ),
  '/stateNotifierProvider': (context) => DefferLibraryWidget(
        libraryFuture: state_notifier_test.loadLibrary(),
        child: (context) {
          return state_notifier_test.StateNotifierProviderTestPage();
        },
      ),
  '/futureProvider': (context) => DefferLibraryWidget(
        libraryFuture: future_provider_test.loadLibrary(),
        child: (context) {
          return future_provider_test.FutureProviderTestPage();
        },
      ),
};
