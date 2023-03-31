import 'dart:async';

import 'package:flutter/material.dart';

//新闻轮播图
class FireNews extends StatefulWidget{
  const FireNews({Key? key}) : super(key: key);
  @override
  State<FireNews> createState() => _FireNewsState();
}

class _FireNewsState extends State<FireNews> {

  int _currentIndex = 0;
  List<Widget> pageList = [];
  late PageController _pageController;
  Timer? t;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    List listData = [
      'https://i0.hdslb.com/bfs/new_dyn/7a7f94b50df3b503e5434229632df65f161775300.png@1554w.webp',
      'https://i0.hdslb.com/bfs/new_dyn/f0f62420a0cd39a1850566b80b3c02b6161775300.png@1554w.webp',
      'https://i0.hdslb.com/bfs/new_dyn/1346f9c7cb4d2a8b1fa67c178df261dc161775300.png@1554w.webp',
    ];
    for (int i = 0; i < listData.length; ++i) {
      pageList.add(Image.network(listData[i]),);
    }
    t = Timer.periodic(const Duration(seconds: 3),(timer){
      _pageController.animateToPage((_currentIndex+1)%pageList.length, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('热门新闻'),
      ),
      body: Column(
        children: [
               SizedBox(
                 height: 205,
                 width: 600,
                 child: Stack(
                   children:[
                     PageView.builder(
                       controller:_pageController,
                       onPageChanged: (index){
                         setState(() {
                           _currentIndex = index%pageList.length;
                           // 0 1 2 0 1 2 0 1 2
                         });
                       },
                     itemCount: 9999,
                       itemBuilder: (context,index){
                         // 0 1 2 3 4 5 6 7 8
                         // 0%3 1%3 2%3 3%3 4%3 5%3 ......
                         // 0 1 2 0 1 2 0 1 2
                         return pageList[index%pageList.length];
                      }
                     ),
                     Positioned(
                         right: 0,
                         left: 0,
                         bottom: 2,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: List.generate(pageList.length, (index){
                             return Container(
                               width: 10,
                               height:10,
                               decoration: BoxDecoration(
                                 color: index==_currentIndex?Colors.pink:Colors.blue,
                                 borderRadius: BorderRadius.circular(20),
                               ),
                             );
                           }).toList()
                         )
                      )
                   ]
                 )
               )
        ],
      ),
    );
  }
}

