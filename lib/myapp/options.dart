import 'package:flutter/material.dart';
import 'package:myapp/myapp/themes.dart';
import 'package:myapp/myapp/scales.dart';

class MyAppOptions {
  MyAppOptions({
    this.theme,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.platform,
    this.showOffscreenLayersCheckerboard = false,
    this.showPerformanceOverlay = false,
    this.timeDilation = 1.0,
    this.showRasterCacheImagesCheckerboard = false,
  });

  // 全局样式
  final MyAppTheme theme;
  // 字体大小配置
  final MyAppTextScaleValue textScaleFactor;
  // 文本对齐配置
  final TextDirection textDirection;

  final double timeDilation;
  
  final TargetPlatform platform;
  //显示性能标签
  final bool showPerformanceOverlay;
  
  final bool showRasterCacheImagesCheckerboard;
  
  final bool showOffscreenLayersCheckerboard;

  MyAppOptions copyWith({
    MyAppTheme theme,
    MyAppTextScaleValue textScaleFactor,
    TextDirection textDirection,
    double timeDilation,
    TargetPlatform platform,
    bool showPerformanceOverlay,
    bool showRasterCacheImagesCheckerboard,
    bool showOffscreenLayersCheckerboard,
  }){
    return MyAppOptions(
      theme: theme ?? this.theme,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard: showOffscreenLayersCheckerboard ?? this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard: showRasterCacheImagesCheckerboard ?? this.showRasterCacheImagesCheckerboard,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final MyAppOptions typedOther = other;
    return theme == typedOther.theme
        && textScaleFactor == typedOther.textScaleFactor
        && textDirection == typedOther.textDirection
        && platform == typedOther.platform
        && showPerformanceOverlay == typedOther.showPerformanceOverlay
        && showRasterCacheImagesCheckerboard == typedOther.showRasterCacheImagesCheckerboard
        && showOffscreenLayersCheckerboard == typedOther.showRasterCacheImagesCheckerboard;
  }

  @override
  int get hashCode => hashValues(
    theme,
    textScaleFactor,
    textDirection,
    timeDilation,
    platform,
    showPerformanceOverlay,
    showRasterCacheImagesCheckerboard,
    showOffscreenLayersCheckerboard,
  );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}



class MyAppOptionsPage extends StatelessWidget {
  const MyAppOptionsPage({
    Key key,
    this.options,
    this.onOptionsChanged,
    this.onSendFeedback,
  }) : super(key: key);

  final MyAppOptions options;
  final ValueChanged<MyAppOptions> onOptionsChanged;
  final VoidCallback onSendFeedback;
  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Text('系统设置'),
    );
  }
}