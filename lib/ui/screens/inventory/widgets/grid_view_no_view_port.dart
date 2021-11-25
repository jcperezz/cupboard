import 'package:flutter/material.dart';

class GridViewNoViewPort extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double childHeight;

  const GridViewNoViewPort(
      {Key? key,
      required this.children,
      required this.crossAxisCount,
      required this.childHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ..._buildRows(),
          ],
        )
      ],
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];
    List<Widget> subList = [];

    for (var i = 0; i < children.length; i++) {
      subList.add(_buildWrapper(children[i]));

      if (i > 0 && i % crossAxisCount == 0) {
        rows.add(Row(
          children: [...subList],
        ));
        subList = [];
      }
    }

    if (subList.isNotEmpty) {
      while (subList.length < crossAxisCount) {
        subList.add(_buildWrapper(Container()));
      }

      rows.add(Row(
        children: [...subList],
      ));
    }

    return rows;
  }

  Widget _buildWrapper(Widget child) {
    return Expanded(
      child: Container(
        height: childHeight,
        child: child,
      ),
    );
  }
}
