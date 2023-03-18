import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/SelfWidget/newsContent.dart';

//  打开详情页面要配置路由
//  这时候就看出来路由传值的作用了0 0需要吧link传过去。

class View0 extends StatefulWidget {
  const View0({Key? key}) : super(key: key);
  @override
  State<View0> createState() => _View0State();
}

class _View0State extends State<View0> {
  @override
  //  老方法
  List _dataList = [];
  int Page = 1;
  bool flag = true;//解决重复请求
  bool hasData = true; // 我是有底线的！ 这一步算是优化了，因为学校新闻太多了，根本滑不到底部
  //  这里定义一个ScrollController
  final ScrollController _view0ScrollController = ScrollController();
  //  这里定义一个Url
  String URLlink='123';

  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    //  监听滚动条事件
    _view0ScrollController.addListener(() {
      //  如果滚动条高度等于页面高度
      if(_view0ScrollController.position.pixels>=_view0ScrollController.position.maxScrollExtent-50){
        print('加载更多');
        _getData();
      }
    });
  }

  Future<void>_getData()async{
    if(flag&&hasData){
      flag = false;
      Dio dio = Dio();
      Response response = await dio.get('http://10.0.2.2:5000/news/list?type=SDXW&page=$Page');
      var newsData = response.data;
      print(response.data is Map);
      //json数据解码变成Map，不然是json字符串乱码
      //jsonDecode
      print(newsData);
      if(response.data['data'].length<13){
        hasData = false;
      }
      setState((){
        _dataList.addAll(newsData['data']);
        Page++;
        flag = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return _dataList.isNotEmpty?
      RefreshIndicator(
              child:ListView.builder(
                  controller: _view0ScrollController,
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
                                  title: Text('${_dataList[index][1]}'),
                                  subtitle: const Text('123'),
                                ),
                                ListTile(
                                  title: Text("${_dataList[index]['title']}"),
                                  subtitle: Text('${_dataList[index]['date']}'),
                                  onTap: (){
                                    print('index=$index');
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return NewsPaperContent0(MyUrl: '${_dataList[index]['link']}',);
                                    }));
                                  },
                                ),
                              ],
                            )
                          ),
                          SizedBox(width: 200,height: 80,child: _sefl_Indicator_TabBar_To_TabBar(),)
                        ],
                      );
                    }else{
                      return Card(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text('${_dataList[index][1]}'),
                                subtitle: const Text('123'),
                              ),
                              ListTile(
                                title: Text("${_dataList[index]['title']}"),
                                subtitle: Text('${_dataList[index]['date']}'),
                                onTap: (){
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
              ),onRefresh: ()async{
            print('下拉刷新');
            _getData();
          })
        :_sefl_Indicator_TabBar_To_TabBar();
  }
}

//  自定义组件
Widget _sefl_Indicator_TabBar_To_TabBar(){
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

