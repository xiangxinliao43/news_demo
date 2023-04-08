import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_demo/unifyscreen.dart';
import 'package:news_demo/service/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_demo/service/backgroundimage.dart';

class BottomBar3 extends StatefulWidget {
  const BottomBar3({Key? key}) : super(key: key);
  @override
  State<BottomBar3> createState() => _BottomBar3State();
}

class _BottomBar3State extends State<BottomBar3> {
  //上下按钮转换
  bool isExpanded = false;
  void _handleTap() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final ImagePicker picker = ImagePicker();

  bool flag = false;

  String? imagePath;
  //相机照片
  _pickerGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      _saveImagePath(image.path); //保存图片路径
    }
    setState(() {
      imagePath = image!.path;
      flag = true;
    });
  }

  //获取SharedPreferences实例
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //读取图片路径
  Future<String?> _getImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath');
  }

  //保存图片路径
  Future<void> _saveImagePath(String path) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('imagePath', path);
  }

  //删除图片路径
  Future<void> _removeImagePath() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('imagePath');
  }

  //弹出框
  void _alertDalog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //这是提示框的一种
            title: const Text("设定手册"),
            content: const Text("我懒得用心写了"),
            actions: [
              TextButton(
                  onPressed: () {
                    print("ok!");
                    Navigator.of(context).pop();
                    //通过Navigator实现点击后消失a
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("not ok!");
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Utils.getImagePath().then((value) {
      if (value != null) {
        setState(() {
          imagePath = value;
          flag = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: const Text('Setting'),
      ),
      body: Stack(
        children: [
          flag
              ? Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
              : ColoredBox(color: Colors.blue[100]!),
          Padding(
            padding:
                EdgeInsets.fromLTRB(SU.w(10), SU.h(10), SU.w(10), SU.h(10)),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SU.h(5),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(flex: 1, child: Center()),
                              Expanded(
                                  flex: 6,
                                  child: button(
                                      '阅读设定', Icons.settings, _alertDalog)),
                              Expanded(
                                flex: 4,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 6,
                                child: button(
                                    '个人资料', Icons.account_circle, _alertDalog),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Center(),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Opacity(
                        opacity: 0.65,
                        child: Card(
                          child: ExpansionTile(
                            title: ListTile(
                              leading: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    SU.w(5), SU.h(8), SU.w(5), SU.h(5)),
                                child: Icon(
                                  Icons.local_offer,
                                  color: Colors.black,
                                  size: SU.sp(25),
                                ),
                              ),
                              title: const Text(
                                '个性化',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'ZhiMangXing'),
                              ),
                              subtitle: const Text(
                                'personality',
                                style: TextStyle(fontSize: 10),
                              ),
                              onTap: () {
                                _handleTap();
                              },
                            ),
                            trailing: Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey,
                              size: 36.0,
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(SU.sp(10)),
                                child: Column(
                                  children: [
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: ListTile(
                                        title: Container(
                                          height: 40.0,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.greenAccent),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.yellow),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.red),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.blue),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.pinkAccent),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              colorselect(Colors.purple),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: const Text('切换主题颜色'),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: ListTile(
                                        title: Text('更换背景图片'),
                                        onTap: () {
                                          _pickerGallery();
                                        },
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: ListTile(
                                        title: const Text('恢复默认主题'),
                                        subtitle: const Text('remake'),
                                        onTap: () async {
                                          await _removeImagePath();
                                          setState(() {
                                            imagePath = null;
                                            flag = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                            onExpansionChanged: (expanded) {
                              setState(() {
                                isExpanded = expanded;
                              });
                            },
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Card(
                            margin: EdgeInsets.all(SU.h(5)),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Login();
                                    }));
                                  },
                                  title: const Center(
                                      child: Text(
                                    '登录',
                                    style: TextStyle(fontSize: 20),
                                  )),
                                  subtitle:
                                      const Center(child: Text('loge in')),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

GestureDetector button(String a, IconData i, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(i, color: Colors.black, size: 15),
          SizedBox(width: SU.w(1)),
          Text(a, style: const TextStyle(color: Colors.black, fontSize: 10)),
        ],
      ),
    ),
  );
}

//主题颜色选择
GestureDetector colorselect(Color c) {
  return GestureDetector(
    onTap: () {

      // 执行操作
    },
    child: CircleAvatar(
      radius: 20,
      backgroundColor: c,
      child: const Icon(Icons.color_lens_outlined),
    ),
  );
}
