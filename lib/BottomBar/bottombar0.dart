import 'package:flutter/material.dart';
import 'package:news_demo/tabbarview/view0.dart';
import 'package:news_demo/tabbarview/view1.dart';
import 'package:news_demo/tabbarview/view2.dart';
import 'package:news_demo/tabbarview/view3.dart';
import 'package:news_demo/tabbarview/view4.dart';
import 'package:news_demo/tabbarview/view5.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BottomBar0 extends StatefulWidget {
  const BottomBar0({Key? key}) : super(key: key);
  @override
  State<BottomBar0> createState() => _BottomBar0State();
}
// Colorize Colors
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class _BottomBar0State extends State<BottomBar0> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 6, vsync: this);
    //  vsync:this
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText('矿大新闻', textStyle: TextStyle(
              color: Colors.blue[900],
              fontFamily: 'ZhiMangXing',
              fontSize: 40
            ), colors: _colorizeColors),
            ColorizeAnimatedText('CUMT NEWS', textStyle: TextStyle(
                color: Colors.blue[900],
                fontSize: 20
            ), colors: _colorizeColors),
          ],
          repeatForever: true,
        ),
        bottom: TabBar(
          isScrollable: true,// 滚动Bar
          indicatorColor: Colors.red[900],
          indicatorPadding: const EdgeInsets.all(4),
          controller: _tabController,
          unselectedLabelColor: Colors.blue[900],
          labelColor:Colors.red[900],
          tabs: const [
            Tab(child: Text('视点新闻',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
            Tab(child: Text('学术聚焦',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
            Tab(child: Text('学术报告',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
            Tab(child: Text('人文课堂',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
            Tab(child: Text('信息公告',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
            Tab(child: Text('校园咨询',style:TextStyle(fontFamily: 'ZhiMangXing',fontSize: 20),),),
          ],
        ),
        leading: const Icon(Icons.fiber_new_rounded),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.local_fire_department_rounded),),
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children:const [
              View0(),
              View1(),
              View2(),
              View3(),
              View4(),
              View5(),
            ],
          ),
        ],
      ),
    );
  }
}
//just改下文件名称
