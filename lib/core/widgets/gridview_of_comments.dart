import 'package:flutter/material.dart';

class GridViewOfComments extends StatelessWidget {
  const GridViewOfComments({
    super.key,
    required this.itemCount,
    this.mainAxisEvent = 160,
    required this.itemBuilder});

  final int itemCount;
  final double? mainAxisEvent;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent:mainAxisEvent,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
        ),
        itemBuilder: itemBuilder
    );
  }
}
