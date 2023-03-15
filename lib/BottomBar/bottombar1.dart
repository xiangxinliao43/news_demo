import 'package:flutter/material.dart';

class BottomBar1 extends StatefulWidget {
  const BottomBar1({Key? key}) : super(key: key);

  @override
  State<BottomBar1> createState() => _BottomBar1State();
}

class _BottomBar1State extends State<BottomBar1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BottomBar1'),
      ),
    );
  }
}