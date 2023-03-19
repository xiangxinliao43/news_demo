import 'package:flutter/material.dart';
import 'package:news_demo/bottombar/bottombar0.dart';
import 'package:news_demo/bottombar/bottombar1.dart';
import 'package:news_demo/bottombar/bottombar2.dart';
import 'package:news_demo/bottombar/bottombar3.dart';

main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexbottomBar = 0;
  //  buttomNavigationBar要用到的页面指示
  final List<Widget> _bottomBar = const [
    BottomBar0(),
    BottomBar1(),
    BottomBar2(),
    BottomBar3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_bottomBar[_currentIndexbottomBar],
      backgroundColor: Colors.yellow[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexbottomBar,
        //  这里的index获取当前页面的索引值
        onTap: (index){
          setState(() {
            _currentIndexbottomBar = index;
          });
        },
        type: BottomNavigationBarType.fixed,//item大于4的时候要用到这个，否则底部颜色全白
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.blue[900]),
        selectedIconTheme: IconThemeData(color: Colors.red[900]),
        unselectedItemColor: Colors.blue[900],//主要用于设置item及字体颜色
        selectedItemColor: Colors.red[900],//主要用于设置item及字体颜色
        unselectedLabelStyle: const TextStyle(fontFamily:'ZhiMangXing' ),//有设置主题与unselectedItemColor时,无作用
        selectedLabelStyle: const TextStyle(fontFamily:'ZhiMangXing' ),////有设置主题与selectedItemColor时,无作用
        items:  const[
          BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: '新闻'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library),label: '视频'),
          BottomNavigationBarItem(icon: Icon(Icons.sunny),label: '未定'),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: '个人'),
        ],
      ),
    );
  }
}

