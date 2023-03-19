import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFview extends StatefulWidget {
  final String url;
  const PDFview({Key? key,required this.url}) : super(key: key);

  @override
  State<PDFview> createState() => _PDFviewState();
}

class _PDFviewState extends State<PDFview> {
  String? _pdfFilePath;//定义一个pdf文件地址

  //获取文件
  Future<String?> getPdfPath()async{
    //获取数据
    Dio dio = Dio();
    Response response = Dio().get(widget.url) as Response;
    //获取缓存目录
    final dir = await getTemporaryDirectory();
    //这里要import dart:io
    //定义一个file文件名
    final file = File('${dir.path}/test.pdf');
    //写入pdf文件
    await file.writeAsBytes(response.data);
    return file.path;
  }
  void loadPdf()async{
    _pdfFilePath = await getPdfPath();
    setState(() {});
  }
  //离开这个页面做的清除工作
  void dispose(){
    super.dispose();
  }
  Future disposePdf()async{
    final file = File(_pdfFilePath!);
    if(await file.exists()){
      file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(future: getPdfPath(),builder: (BuildContext context, AsyncSnapshot<String?> snapshot){
      if(snapshot.hasData){
        return PDFView(filePath: _pdfFilePath,);
      }else{
        return const Text("加载中");
      }
    });
  }
}

