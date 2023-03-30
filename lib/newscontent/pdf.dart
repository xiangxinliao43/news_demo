import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:news_demo/unifyscreen.dart';
class Pdf extends StatelessWidget {
  final String url;

  Pdf({required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SU.w(300),
      height: SU.h(600),
      child: PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
