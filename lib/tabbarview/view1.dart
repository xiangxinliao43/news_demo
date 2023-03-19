import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/exampleview.dart';

class View1 extends StatefulWidget {
  const View1({Key? key}) : super(key: key);

  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  @override
  Widget build(BuildContext context) {
    return const MyView(type: 'XSJJ');
  }
}

