import 'package:flutter/material.dart';

class RouteListItem {
  final String title;
  final String route;

  const RouteListItem({
    required this.title,
    required this.route,
  });
}

class CustomRouteList extends StatefulWidget {
  final List<RouteListItem> items;

  const CustomRouteList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CustomRouteList> createState() => _CustomRouteListState();
}

class _CustomRouteListState extends State<CustomRouteList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: _listItem,
      separatorBuilder: _sepetatorBuilder,
      itemCount: widget.items.length,
    );
  }

  Widget _listItem(BuildContext context, int index) {
    final item = widget.items[index];
    return ListTile(
      onTap: () => _onTap(context, item),
      title: Text(item.title),
    );
  }

  void _onTap(BuildContext context, RouteListItem item) {
    Navigator.of(context).pushNamed(item.route);
  }

  Widget _sepetatorBuilder(BuildContext context, int index) {
    return Divider(
      color: Colors.green.withOpacity(0.5),
      height: 0.5,
    );
  }
}
