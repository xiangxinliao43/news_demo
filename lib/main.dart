import 'package:flutter/material.dart';
import 'package:news_demo/bottombar/bottombar0.dart';
import 'package:news_demo/bottombar/bottombar1.dart';
import 'package:news_demo/bottombar/bottombar2.dart';
import 'package:news_demo/bottombar/bottombar3.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

main(){
  runApp(ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          home: HomePage(),
        );
      }));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexbottomBar = 0;
  final List<Widget> _bottomBar = const [
    BottomBar0(),
    BottomBar1(),
    BottomBar2(),
    BottomBar3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomBar[_currentIndexbottomBar],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexbottomBar,
        onTap: (index) {
          setState(() {
            _currentIndexbottomBar = index;
          });
        },
        type: BottomNavigationBarType.fixed, //item大于4的时候要用到这个，否则底部颜色全白
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.blue[900]),
        selectedIconTheme: IconThemeData(color: Colors.red[900]),
        unselectedItemColor: Colors.blue[900],
        selectedItemColor: Colors.red[900],
        unselectedLabelStyle: const TextStyle(fontFamily: 'ZhiMangXing'),
        selectedLabelStyle: const TextStyle(fontFamily: 'ZhiMangXing'),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: '新闻'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: '视频'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: '留言板'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
        ],
      ),
    );
  }
}
