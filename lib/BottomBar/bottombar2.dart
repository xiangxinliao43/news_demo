import 'package:flutter/material.dart';

class BottomBar2 extends StatefulWidget {
  const BottomBar2({Key? key}) : super(key: key);

  @override
  State<BottomBar2> createState() => _BottomBar2State();
}

class _BottomBar2State extends State<BottomBar2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BottomBar2'),
      ),
    );
  }
}