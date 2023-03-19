import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/exampleview.dart';

class View4 extends StatefulWidget {
  const View4({Key? key}) : super(key: key);

  @override
  State<View4> createState() => _View4State();
}

class _View4State extends State<View4> {
  @override
  Widget build(BuildContext context) {
    return const MyView(type: 'XWGG');
  }
}
