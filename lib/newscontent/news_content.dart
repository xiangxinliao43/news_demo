import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_demo/selfwidget/witgt_self.dart';
import 'package:news_demo/unifyscreen.dart';
import '../newscontent/pdf.dart';

class NewsPaperContent0 extends StatefulWidget {
  final String url;
  const NewsPaperContent0({Key? key,required this.url}) : super(key: key);
  @override
  State<NewsPaperContent0> createState() => _NewsPaperContent0State();
}

class _NewsPaperContent0State extends State<NewsPaperContent0> {

  List _contentList = [];
  Map _contentsData = {};
  String? pdfFlePath;

  getData() async {
    int retryCount = 0;
    bool success = false;
    while (!success && retryCount < 20) {
      try {
        Response response = await Dio().get('http://118.195.147.37:5672/news/content?link=${widget.url}');

        var _contentsContent = response.data['contents'];
        _contentsData = response.data;
        setState(() {
          _contentList = _contentsContent;
        });
        success = true;
      } catch (e) {
        print('Error fetching data: $e');
        retryCount++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('nesContent'),
      ),
      body: _contentList.isNotEmpty ?
      Padding(
        padding: EdgeInsets.all(SU.h(20)),
        child: ListView.builder(
          itemCount: _contentList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Text('${_contentsData['title']}', style: const TextStyle(fontSize: 35));
            } else if (index == 1) {
              return Column(
                children: [
                  author(_contentsData),
                  SizedBox(height: SU.h(20)),
                ],
              );
            } else {
              switch (_contentList[index - 2]['type']) {
                case 'text':
                  return Column(
                    children: [
                      Text(_contentList[index - 2]['content']),
                      SizedBox(height: SU.h(20)),
                    ],
                  );
                case 'image':
                  return Column(
                    children: [
                      Image.network(_contentList[index - 2]['content']),
                    ],
                  );
                case 'pdf':
                  print('pdf');
                  return Pdf(url:_contentList[index - 2]['content']);
                default:
                  return Container();
              }
            }
          },
        ),
      )
          : Center(child: mw_cumtNewsTitleText()),
    );
  }

  ListTile author(Map m){
    return ListTile(
      title:Text('作者：${m['author']}',style: const TextStyle(fontSize:20)),
      subtitle: Text('日期：${m['date']}\n阅读量：${m['visit_count']}'),
      leading: Image.network('https://i0.hdslb.com/bfs/article/5f54ac336f84271d3b83a1fbd800602464d86f06.jpg@942w_942h_progressive.webp'),
      trailing: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        child: const Text('Follow'),
      ),
    );
  }
}
