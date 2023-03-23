import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/tabbarview/news_list_entity.dart';
import 'package:news_demo/somewidget/glassmorphism.dart';
import 'package:news_demo/somewidget/news_content.dart';

class MyView extends StatefulWidget {
  final String type;
  const MyView({Key? key,required this.type}) : super(key: key);
  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  int page = 0;
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
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://10.0.2.2:5000/news/list?type=${widget.type}&page=$page');
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
                  Image.network('https://i0.hdslb.com/bfs/article/6e174bafee9c4defcb40daf45e4bf27ec00caddc.png@942w_progressive.webp'
                  ,fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  ListView.builder(
                      controller: _viewScrollController,
                      itemCount: dataList!.length,
                      itemBuilder: (context,index){
                        if(index==dataList.length-1){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5,),
                              GlassMorphism(
                                blur:10,
                                opacity:0.2,
                                child: ListTile(
                                  title: Text(dataList[index].title),
                                  subtitle: Text(dataList[index].date),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return NewsPaperContent0(MyUrl: dataList[index].link);
                                    }));
                                  },
                                ),
                              ),
                              circleloading(),
                            ],
                          );
                        }
                        else{
                          return Column(
                            children: [
                              const SizedBox(height: 5,),
                              GlassMorphism(
                                blur:20,
                                opacity:0.1,
                                child: ListTile(
                                  title: Text(dataList[index].title),
                                  subtitle: Text(dataList[index].date),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return NewsPaperContent0(MyUrl: dataList[index].link);
                                    }));
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      }
                  ),
                ],
              );
            }else{
              return circleloading();
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


Widget circleloading(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 10,),
        Text('Loading...'),
      ],
    ),
  );
}