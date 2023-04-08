import 'package:flutter/material.dart';
import 'package:news_demo/bottombar/b0page/newsbefore.dart';
import '../tabbarview/exampleview.dart';
import 'package:news_demo/selfwidget/witgt_self.dart';
import 'package:news_demo/unifyscreen.dart';
import 'package:news_demo/bottombar/b0page/firenews.dart';

class BottomBar0 extends StatefulWidget {
  const BottomBar0({Key? key}) : super(key: key);
  @override
  State<BottomBar0> createState() => _BottomBar0State();
}

class _BottomBar0State extends State<BottomBar0> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  List ntype = ['视点新闻', '学术聚焦', '学术报告', '人文课堂', '信息公告', '校园咨询'];
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  //页面跳转_热点新闻
  void toFirePage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const FireNews();
    }));
  }
  void toNewsBeforePage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Newsbefore();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar(_tabController, toFirePage,toNewsBeforePage),
      body: body(_tabController),
    );
  }
}

// appBar
AppBar appBar(TabController tabController, VoidCallback toFirePage,VoidCallback toNewsBeforePage) {
  return AppBar(
    toolbarHeight: SU.h(40),
    backgroundColor: Colors.blue[900],
    centerTitle: true,
    title: SizedBox(height: 33, child: mw_search()),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(SU.h(40)),
      child: SizedBox(
        height: 35,
        child: Material(
          color: Colors.white,
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colors.red[900],
            labelColor: Colors.red[900],
            unselectedLabelColor: Colors.blue[900],
            indicatorPadding: const EdgeInsets.all(4),
            controller: tabController,
            tabs: [
              for (var ntype in ['视点新闻', '学术聚焦', '学术报告', '人文课堂', '信息公告', '校园咨询'])
                Tab(child: Text(ntype, style: TextStyle(color: Colors.blue[900], fontSize: SU.sp(20), fontFamily: 'ZhiMangXing',),),)
            ],
          ),
        ),
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.history,),
      onPressed: (){
        toNewsBeforePage();
      },
    ),
    actions: [
      IconButton(
        onPressed: () {
          toFirePage();
        },
        icon: const Icon(Icons.local_fire_department_rounded),
      ),
      IconButton(onPressed: () {

      }, icon: const Icon(Icons.dark_mode_outlined)),
    ],
  );
}

//body
Stack body(TabController tabController,) {
  return Stack(
    children: [
      TabBarView(
        controller: tabController,
        children: [
          for (var type in ['SDXW', 'XSJJ', 'XSBG', 'RWJT', 'XWGG', 'SYKX'])
            MyView(type: type),
        ],
      ),
    ],
  );
}
