import 'package:flutter/material.dart';

class BottomBar3 extends StatefulWidget {
  const BottomBar3({Key? key}) : super(key: key);

  @override
  State<BottomBar3> createState() => _BottomBar3State();
}

class _BottomBar3State extends State<BottomBar3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BottomBar3'),
      ),
    );
  }
}