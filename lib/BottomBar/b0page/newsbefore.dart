import 'package:flutter/material.dart';

class Newsbefore extends StatefulWidget {
  const Newsbefore({Key? key}) : super(key: key);

  @override
  State<Newsbefore> createState() => _NewsbeforeState();
}

class _NewsbeforeState extends State<Newsbefore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('历史浏览记录'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('浏览记录1'),
          )
        ],
      ),
    );
  }
}







































