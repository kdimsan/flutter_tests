// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  int value = 10;
  runApp(MyApp(title: 'Primeiro App', value: value));
}

class MyApp extends StatelessWidget {
  final String title;
  final int value;
  const MyApp({Key? key, this.title = '', this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(
            'Olá mundo! $value',
            style: TextStyle(fontSize: 50, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
