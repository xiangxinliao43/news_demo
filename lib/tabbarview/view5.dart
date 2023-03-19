import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/exampleview.dart';

class View5 extends StatefulWidget {
  const View5({Key? key}) : super(key: key);

  @override
  State<View5> createState() => _View5State();
}

class _View5State extends State<View5> {
  @override
  Widget build(BuildContext context) {
    return const MyView(type: 'SYKX');
  }
}
