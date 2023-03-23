import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class NewsPaperContent0 extends StatefulWidget {
  //  创建一个url接收不同的link
  //  构造函数写入传值的URL

  final String MyUrl;

  const NewsPaperContent0({Key? key,required this.MyUrl}) : super(key: key);

  @override
  State<NewsPaperContent0> createState() => _NewsPaperContent0State();
}

class _NewsPaperContent0State extends State<NewsPaperContent0> {

  //  创建一个List接收返回来的 contents 数据

  List _contentList = [];
  Map _contentMap = {};
  var _contentsData;

  getData()async{
    Response response = await Dio().get('http://10.0.2.2:5000/news/content?link=${widget.MyUrl}');
    print(response.data is Map);
    var _contentsContent = response.data['contents'];
    _contentsData = response.data;
    setState(() {
      _contentList = _contentsContent;
      _contentMap = response.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('nesContent'),
      ),
      body: _contentList.isNotEmpty?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _contentList.length,
                itemBuilder: (BuildContext context,int index){
                  if(index==0){
                    return Text('${_contentsData['title']}',style: const TextStyle(fontSize:40));
                  }else if(index==1){
                    return Column(
                      children: [
                        ListTile(
                            title:Text('作者：${_contentsData['author']}',style: const TextStyle(fontSize:20)),
                            subtitle: Text('日期：${_contentsData['date']}\n阅读量：${_contentsData['visit_count']}'),
                            leading: Image.network('https://i0.hdslb.com/bfs/article/5f54ac336f84271d3b83a1fbd800602464d86f06.jpg@942w_942h_progressive.webp'),
                            trailing: ElevatedButton(onPressed: (){
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),child: const Text('Fllow'),
                            ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    );
                  }else {
                    switch (_contentList[index]['type']) {
                      case 'text':
                        return Column(
                          children: [
                            Text(_contentList[index]['content']),
                            const SizedBox(height: 10,)
                          ],
                        );
                      case 'image':
                        return Column(
                          children: [
                            Image.network(_contentList[index]['content']),
                          ],
                        );
                      case 'pdf':
                        return  Container();
                      default:
                        return Container();
                    }
                  }
                }
            ),
          )
          :Center(
           child: Container(
            height: 300,
            width: 300,
              child: Image.network('https://i0.hdslb.com/bfs/article/05722d579c8cedd3c859e31d3b4302fd3718706e.jpg@300w_300h_progressive.webp'),
        ),
    ),
    );
  }
}
