import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/somewidget//newsContent.dart';

class MyView extends StatefulWidget {
  final String type;
  const MyView({Key? key,required this.type}) : super(key: key);
  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  final List _dataList = [];
  int page = 0;
  bool flag = true;
  //解决重复请求
  bool hasData = true;
  //  这里定义一个ScrollController
  final ScrollController _viewScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    //  监听滚动条事件
    _viewScrollController.addListener((){
      //  如果滚动条高度等于页面高度
      if(_viewScrollController.position.pixels>=_viewScrollController.position.maxScrollExtent-50){
        //ignore:avoid_print
        print('加载更多');
        _getData();
      }
    });
  }

  Future<void>_getData()async{
    if(flag&&hasData){
      flag = false;
      Dio dio = Dio();
      Response response = await dio.get('http://10.0.2.2:5000/news/list?type=${widget.type}&page=$page');
      var newsData = response.data;
      //ignore:avoid_print
      print(response.data is Map);
      //json数据解码变成Map，不然是json字符串乱码
      //jsonDecode
      //ignore:avoid_print
      print(newsData);
      if(response.data['data'].length<13){
        hasData = false;
      }
      setState((){
        _dataList.addAll(newsData['data']);
        page++;
        flag = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return _dataList.isNotEmpty?
    RefreshIndicator(
        child:ListView.builder(
            controller: _viewScrollController,
            itemCount:_dataList.length,
            itemBuilder: (context,index){
              if(index==_dataList.length-1){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text("${_dataList[index]['title']}"),
                              subtitle: Text('${_dataList[index]['date']}'),
                              onTap: (){
                                //ignore:avoid_print
                                print('index=$index');
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                  return NewsPaperContent0(MyUrl:'${_dataList[index]['link']}',);
                                }));
                              },
                            ),
                          ],
                        )
                    ),
                    SizedBox(width: 200,height: 80,child: circleloading(),)
                  ],
                );
              }else{
                return Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text("${_dataList[index]['title']}"),
                          subtitle: Text('${_dataList[index]['date']}'),
                          onTap: (){
                            //ignore:avoid_print
                            print('index=$index');
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return NewsPaperContent0(MyUrl: '${_dataList[index]['link']}',);
                            }));
                          },
                        ),
                      ],
                    )
                );
              }
            }
        ),onRefresh:()async{
      //ignore:avoid_print
      print('下拉刷新');
      _getData();
    })
        :circleloading();
  }
}

//  自定义组件
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