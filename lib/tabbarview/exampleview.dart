import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/tabbarview/news_list_entity.dart';

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
    _viewScrollController.addListener(() {
      if(_viewScrollController.position.pixels>=_viewScrollController.position.maxScrollExtent-50){
        print('isLoading');
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: _myStreamController.stream,
        builder:(context,snapshot){
          if(snapshot.hasData){
            final dataList = snapshot.data;
            return ListView.builder(
                controller: _viewScrollController,
                itemCount: dataList!.length,
                itemBuilder: (context,index){
                  if(index==dataList.length-1){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(dataList[index].title),
                          subtitle: Text(dataList[index].date),
                        ),
                        circleloading(),
                      ],
                    );
                  }
                  else{
                    return ListTile(
                      title: Text(dataList[index].title!),
                      subtitle: Text(dataList[index].date!),
                    );
                  }
                }
            );
          }else{
            return const SizedBox(height: 50,width: 50,child: CircularProgressIndicator());
          }
        }
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