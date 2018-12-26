import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/myapp/options.dart';
import 'package:myapp/myapp/themes.dart';
import 'package:myapp/myapp/scales.dart';
import 'package:myapp/myapp/home.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import 'demos.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
    this.testMode = false,
  }) : super(key:key);
  
  final bool testMode;

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyAppOptions _options;// 系统设置
  Timer _timeDilationTimer;

  //获取所有路由列表
  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      kAllMyAppDemos,
      key: (dynamic demo) => '${demo.routeName}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    _options = MyAppOptions(
      theme: kLightMyAppTheme,
      textScaleFactor: kAllMyAppTextScaleValue[0],
      timeDilation: timeDilation,
      platform: defaultTargetPlatform,
    );
  }

  void _handleOptionsChanged(MyAppOptions newOptions) {
    setState(() {
      print(newOptions.timeDilation.toString() + ' newOptions.timeDilation');
      print(_options.timeDilation.toString() + '_options.timeDilation');

      if (_options.timeDilation != newOptions.timeDilation) {
        _timeDilationTimer?.cancel();
        _timeDilationTimer = null;
        if (newOptions.timeDilation > 1.0) {
          _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
            timeDilation = newOptions.timeDilation;
          });
        } else {
          timeDilation = newOptions.timeDilation;
        }
      }
      _options = newOptions;
    });
  }

  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget home = MyAppHome(
      testMode: widget.testMode,
    );

    return MaterialApp(
       theme: _options.theme.data.copyWith(platform: _options.platform),
       title: 'MyApp',
       color: Colors.grey,
       showPerformanceOverlay: _options.showPerformanceOverlay,
       checkerboardOffscreenLayers: _options.showOffscreenLayersCheckerboard,
       checkerboardRasterCacheImages: _options.showRasterCacheImagesCheckerboard,
       debugShowCheckedModeBanner: false,
       routes: _buildRoutes(),
       home: home,
       builder: (BuildContext context, Widget child){
         return Directionality(
          textDirection: _options.textDirection,
          child: _applyTextScaleFactor(child),
        );
       },
    );
  }
}

