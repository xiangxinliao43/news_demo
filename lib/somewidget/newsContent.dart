import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/somewidget//pdfView2.dart';

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
                    return Text('${_contentsData['title']}',style: const TextStyle(fontSize:40,fontFamily: 'ZhiMangXing'));
                  }else if(index==1){
                    return Text('作者：${_contentsData['author']}',style: const TextStyle(fontSize:40,fontFamily: 'ZhiMangXing'));
                  }else {
                    switch (_contentList[index]['type']) {
                      case 'text':
                        return Text(_contentList[index]['content']);
                      case 'image':
                        return Image.network(_contentList[index]['content']);
                      case 'pdf':
                        return  PDFview(url:_contentList[index]['content']);
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
