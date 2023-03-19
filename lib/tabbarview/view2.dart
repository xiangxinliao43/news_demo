import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/exampleview.dart';

class View2 extends StatefulWidget {
  const View2({Key? key}) : super(key: key);

  @override
  State<View2> createState() => _View2State();
}

class _View2State extends State<View2> {
  @override
  Widget build(BuildContext context) {
    return const MyView(type: 'XSBG',);
  }
}
