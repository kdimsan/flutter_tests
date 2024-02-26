// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageOne(),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Page One'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Go to second page'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondPage();
              }));
            },
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Back to Page One'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
