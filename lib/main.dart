// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    name: 'Ricardo',
  ));
}

class MyApp extends StatefulWidget {
  //State not changeble
  final String name;
  const MyApp({super.key, this.name = ''});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Widget to change states
  int salary = 7000;

  void incrementSalary(int value) {
    setState(() {
      salary += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          incrementSalary(200);
        },
        child: Text(
          'O salário de ${widget.name} é: $salary',
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
