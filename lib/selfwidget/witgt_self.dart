import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:ui';

//闪光标题
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

Widget mw_cumtNewsTitleText(){
  return Center(
    child: AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText('矿大新闻', textStyle: TextStyle(
            color: Colors.blue[900],
            fontFamily: 'ZhiMangXing',
            fontSize: 40
        ), colors: _colorizeColors),
        ColorizeAnimatedText('CUMT NEWS', textStyle: TextStyle(
            color: Colors.blue[900],
            fontSize: 20
        ), colors: _colorizeColors),
      ],
      repeatForever: true,
    ),
  );
}



//加载动画
Widget mw_circleloading(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 10,),
        Text('loading...'),
      ],
    ),
  );
}

//搜索框
Widget mw_search(){
  return TextField(
    style: TextStyle(fontSize: 16.0),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      hintText: '热点新闻',
      prefixIcon: const Icon(Icons.search),
    ),
  );
}

//玻璃效果
class GlassMorphism extends StatefulWidget {
  final double blur;
  final double opacity;
  final Widget child;
  const GlassMorphism({Key? key,required this.blur,required this.child,required this.opacity}) : super(key: key);

  @override
  State<GlassMorphism> createState() => _GlassMorphismState();
}

class _GlassMorphismState extends State<GlassMorphism> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur,sigmaY: widget.blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(widget.opacity),
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            border: Border.all(
              width: 1.5,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}


//tabBar的效果
 List<Color>_colorizeColors1 = [
  Colors.blue[900]!,
  Colors.blue[700]!,
  Colors.blue[400]!,
  Colors.blue[200]!,
];
Widget mw_tbt(String t,bool i){
  return Center(
    child: AnimatedTextKit(
      pause: Duration(microseconds: 500),
      animatedTexts: [
        ColorizeAnimatedText(t, textStyle: TextStyle(
            color: Colors.blue[900],
            fontFamily: 'ZhiMangXing',
            fontSize: 20
        ), colors: _colorizeColors1, speed: Duration(milliseconds: 500)),
        ColorizeAnimatedText(t, textStyle: TextStyle(
          color: Colors.blue[900],
          fontSize: 20,
          fontFamily: 'ZhiMangXing',
        ), colors: _colorizeColors1, speed: Duration(milliseconds: 500)),
      ],
      repeatForever: true,
    ),
  );
}



















