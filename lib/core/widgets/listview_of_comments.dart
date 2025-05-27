import 'package:flutter/material.dart';

class ListViewOfComments extends StatelessWidget {
  const ListViewOfComments({super.key, required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final Widget? Function(BuildContext,int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(2),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: itemBuilder,
        itemCount: itemCount
    );
  }
}
