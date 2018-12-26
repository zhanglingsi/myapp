import 'package:flutter/material.dart';

//缩放字体设置
class MyAppTextScaleValue{

  const MyAppTextScaleValue(this.label,this.scale);

  final double scale;
  final String label;

  @override
  bool operator == (dynamic other){
    if(runtimeType != other.runtimeType){
      return false;
    }
    final MyAppTextScaleValue typeOther = other;
    return scale == typeOther.scale && typeOther.label == label; 
  }

  @override
  int get hashCode => hashValues(scale, label);

  @override
  String toString(){
    return '$runtimeType($label)';
  }
}

const List<MyAppTextScaleValue> kAllMyAppTextScaleValue = <MyAppTextScaleValue>[
  MyAppTextScaleValue('系统默认', null),
  MyAppTextScaleValue('小', 0.8),
  MyAppTextScaleValue('正常', 1.0),
  MyAppTextScaleValue('大', 1.3),
  MyAppTextScaleValue('超大', 2.0),
];