import 'package:flutter/material.dart';
import 'package:myapp/myapp/app.dart';
import 'package:myapp/myapp/home.dart';

void main(List<String> args) {
  MyAppHome.showPreviewBanner = false;
  runApp(const MyApp(
    testMode: true,
  ));
}