import 'package:flutter/material.dart';

class DefferLibraryWidget extends StatelessWidget {
  final WidgetBuilder child;

  final Future libraryFuture;

  const DefferLibraryWidget({
    Key? key,
    required this.libraryFuture,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: libraryFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return _errorWidget(snapshot.error);
          }
          return child(ctx);
        }

        return _loadWidget();
      },
    );
  }

  Widget _loadWidget() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorWidget(error) {
    return Scaffold(
      body: Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
