import 'package:flutter/material.dart';
import 'package:news_demo/service/videoplay.dart';

class BottomBar1 extends StatefulWidget {
  const BottomBar1({Key? key}) : super(key: key);

  @override
  State<BottomBar1> createState() => _BottomBar1State();
}

class _BottomBar1State extends State<BottomBar1> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text('假装我有接口'),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
              child: Stack(
                children: [
                  ChewieVideoWidget1('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                  Positioned(
                    right: 5,
                    top: MediaQuery.of(context).size.height / 2 - 60,
                    child: ButtonGroup(
                      isLiked: isLiked,
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                  )
                ],
              )
          ),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://v-cdn.zjol.com.cn/276982.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://media.w3.org/2010/05/sintel/trailer.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://v-cdn.zjol.com.cn/276989.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
          Center(child: Stack(
            children: [
              ChewieVideoWidget1('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
              Positioned(
                right: 5,
                top: MediaQuery.of(context).size.height / 2 - 60,
                child: ButtonGroup(
                  isLiked: isLiked,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}


class ButtonGroup extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onPressed;

  const ButtonGroup({Key? key, required this.isLiked, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.share,color: Colors.white,),
          onPressed: () {},
        ),
        const SizedBox(
          height: 20,
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.comment,color: Colors.white,),
          onPressed: () {},
        ),
        const SizedBox(
          height: 20,
        ),
        IconButton(
          iconSize: 30,
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.white,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}