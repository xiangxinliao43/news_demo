import 'package:flutter/material.dart';

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