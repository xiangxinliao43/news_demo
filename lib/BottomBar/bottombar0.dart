import 'package:flutter/material.dart';
import 'package:news_demo/TabBarViewChild/view0.dart';
import 'package:news_demo/TabBarViewChild/view1.dart';
import 'package:news_demo/TabBarViewChild/view2.dart';
import 'package:news_demo/TabBarViewChild/view3.dart';
import 'package:news_demo/TabBarViewChild/view4.dart';
import 'package:news_demo/TabBarViewChild/view5.dart';


class BottomBar0 extends StatefulWidget {
  const BottomBar0({Key? key}) : super(key: key);

  @override
  State<BottomBar0> createState() => _BottomBar0State();
}

class _BottomBar0State extends State<BottomBar0> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  double _view0Height = 0;
  //  hey
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 6, vsync: this);
    //  vsync:this
    print('$_view0Height');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text('矿大新闻',style: TextStyle(fontFamily: 'ZhiMangXing',fontSize: 40,color: Colors.blue[900]),),
        bottom: TabBar(
          isScrollable: true,// 滚动Bar
          indicatorColor: Colors.red[900],
          indicatorPadding: const EdgeInsets.all(4),
          controller: _tabController,
          unselectedLabelColor: Colors.teal[900],
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
      ),
      body: TabBarView(
        controller: _tabController,
        children:[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // 获取View0的高度
              _view0Height = constraints.maxHeight;
              // 返回View0
              return const View0();
            },
          ),
          View1(),
          View2(),
          View3(),
          View4(),
          View5(),
        ],
      ),
    );
  }
}
