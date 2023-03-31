import 'package:flutter/material.dart';
import 'package:news_demo/service/backgroundimage.dart';
import 'dart:io';

class BottomBar2 extends StatefulWidget {
  const BottomBar2({Key? key}) : super(key: key);

  @override
  State<BottomBar2> createState() => _BottomBar2State();
}

class _BottomBar2State extends State<BottomBar2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:Column(
          children: [
            UserAccountsDrawerHeader(
                accountName:const Text('mirrSo'),
                accountEmail: const Text('123@gamil.com'),
                currentAccountPicture:ClipOval(
                  child: Image.network('https://i0.hdslb.com/bfs/article/7b47fb1864b96c128bae7d4a0a3f07e8cedb65c0.jpg@942w_528h_progressive.webp', fit: BoxFit.cover,),),
            ),
            const ListTile(title: Text("Tile1"),),
            const Divider(color: Colors.black,),
            const ListTile(title: Text("Tile2"),),
            const Divider(color: Colors.black,),
            const ListTile(title: Text("Tile3"),),
            const Divider(color: Colors.black,),
            const ListTile(title: Text("Tile4"),),
            const Divider(color: Colors.black,),
          ],
        ) ,
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text('Jys\'s Chat'),
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.7,
              child: SizedBox(
                height: 300,
                width: 300,
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      '登陆后查看',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FutureBuilder(
              future: Utils.getImagePath(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (!snapshot.hasData) {
                  return Container(); // 如果还没有保存过图片路径，则显示空容器。
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(snapshot.data!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
