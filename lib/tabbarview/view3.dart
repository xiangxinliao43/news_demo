import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/exampleview.dart';

class View3 extends StatefulWidget {
  const View3({Key? key}) : super(key: key);

  @override
  State<View3> createState() => _View3State();
}

class _View3State extends State<View3> {
  @override
  Widget build(BuildContext context) {
    return const MyView(type: 'RWJT');
  }
}

