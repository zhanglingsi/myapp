import 'package:flutter/material.dart';


class Demo1 extends StatefulWidget {
  static const String routeName = '/demo1';

  _Demo1State createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text('hello'),
       ),
    );
  }
}