import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/tabbarview/news_list_entity.dart';
import 'package:news_demo/newscontent/news_content.dart';
import 'package:news_demo/selfwidget/witgt_self.dart';
import 'package:news_demo/unifyscreen.dart';
import 'package:news_demo/service/backgroundimage.dart';
import 'dart:io';



class MyView extends StatefulWidget {

  final String type;
  const MyView({Key? key,required this.type}) : super(key: key);
  @override
  State<MyView> createState() => _MyViewState();

}

class _MyViewState extends State<MyView> {

  int page = 1;
  NewsListEntity? entity;
  bool flag = true;
  bool hasData = true;
  int time=  0;
  final List _newslistData=[];
  final ScrollController _viewScrollController = ScrollController();
  final StreamController<List> _myStreamController = StreamController<List>.broadcast();

  Future _loadData() async {
    if (!flag) {
      print('please waiting sometimes');
      return;
    }
    flag = false;
    int retryCount = 0; // 记录重试次数
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://118.195.147.37:5672/news/list?type=${widget.type}&page=$page');
      entity = NewsListEntity.fromJson(response.data);
      var _tempDataList = entity!.data;
      _newslistData.addAll(_tempDataList!);
      page++;
      _myStreamController.add(_newslistData);
      print('hahaha');
      print('time=$time,page=$page');
      time++;
    } catch (e) {
      print('load data error: $e');
      while (retryCount < 100) { // 最多重试 100 次
        await Future.delayed(Duration(milliseconds: 100)); // 延迟500毫秒再重试
        try {
          Dio dio = Dio();
          Response response = await dio.get('http://118.195.147.37:5672/news/list?type=${widget.type}&page=$page');
          entity = NewsListEntity.fromJson(response.data);
          var _tempDataList = entity!.data;
          _newslistData.addAll(_tempDataList!);
          page++;
          _myStreamController.add(_newslistData);
          print('hahaha');
          print('time=$time,page=$page');
          time++;
          break; // 请求成功后跳出while循环
        } catch (e) {
          print('load data error: $e');
          retryCount++;
        }
      }
    } finally {
      flag = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _viewScrollController.addListener((){
      if(_viewScrollController.position.pixels>=_viewScrollController.position.maxScrollExtent-50){
        print('isLoading');
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: StreamBuilder<List>(
          stream: _myStreamController.stream,
          builder:(context,snapshot){
            if(snapshot.hasData){
              final dataList = snapshot.data;
              return Stack(
                children: [
                  FutureBuilder(
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
                          child:Container() // 页面的其余代码。
                      );
                    },
                  ),
                  // Image.network('https://i0.hdslb.com/bfs/article/6e174bafee9c4defcb40daf45e4bf27ec00caddc.png@942w_progressive.webp'
                  // ,fit: BoxFit.cover,
                  //   height: double.infinity,
                  //   width: double.infinity,
                  // ),
                  ListView.builder(

                      controller: _viewScrollController,
                      itemCount: dataList!.length,
                      itemBuilder: (context,index){
                        if(index==dataList.length-1){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: SU.h(5),),
                              GlassMorphism(
                                blur:10,
                                opacity:0.2,
                                child: ListTile(
                                  title: Text(dataList[index].title),
                                  subtitle: Text(dataList[index].date),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return NewsPaperContent0(url: dataList[index].link);
                                    }));
                                  },
                                ),
                              ),
                              mw_cumtNewsTitleText(),
                            ],
                          );
                        }
                        else{
                          return Column(
                            children: [
                              SizedBox(height: SU.h(5),),
                              GlassMorphism(
                                blur:20,
                                opacity:0.1,
                                child: ListTile(
                                  title: Text(dataList[index].title),
                                  subtitle: Text(dataList[index].date),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return NewsPaperContent0(url: dataList[index].link);
                                    }));
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      }
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        _viewScrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                      backgroundColor: Colors.blue[900],
                      child: const Icon(Icons.arrow_upward),
                    ),
                  ),
                ],
              );
            }else{
              return mw_cumtNewsTitleText();
            }
          }
      ),
      onRefresh: ()async{
        _loadData();
        //ignore:avoid_print
        print('下拉刷新');
      },
    );
  }
}