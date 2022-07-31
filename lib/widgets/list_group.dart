import 'package:flutter/material.dart';

import '../constants.dart';

class ListGroup extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const ListGroup({
    Key? key,
    required this.children,
    this.backgroundColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      margin: margin,
      padding: padding,
      child: Column(
        children: List.generate(
            children.length * 2 - 1,
            (index) =>
                (index % 2) == 0 ? children[index ~/ 2] : Constants.divider),
      ),
    );
  }
}
