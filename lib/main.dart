// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = '0';

  void calculate(String pressed) {
    switch (pressed) {
      case '4':
      case '5':
      case '6':
      case '.':
        setState(() {
          result += pressed;
          int intNumber = int.parse(result);
          result = intNumber.toString();
        });
        break;
      case 'AC':
        setState(() {
          result = '0';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(result),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () => calculate('AC'), child: Text('AC')),
                Text(''),
                Text(''),
                Text('Back'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('7'),
                Text('8'),
                Text('9'),
                Text('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate('4'),
                  child: Text('4'),
                ),
                GestureDetector(
                  onTap: () => calculate('5'),
                  child: Text('5'),
                ),
                GestureDetector(
                  onTap: () => calculate('6'),
                  child: Text('6'),
                ),
                Text('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('3'),
                Text('2'),
                Text('1'),
                Text('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('0'),
                GestureDetector(
                  onTap: () => calculate('.'),
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Text('='),
                Text('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
