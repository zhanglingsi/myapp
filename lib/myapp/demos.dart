import 'package:flutter/material.dart';
import 'package:myapp/myapp/icons.dart';
import 'package:myapp/demo/class1/backdrop_demo.dart';
import 'package:myapp/demo/class2/bottom_app_bar_demo.dart';
import 'package:myapp/demo/class3/bottom_navigation_demo.dart';
import 'package:myapp/demo/class4/cards_demo.dart';
import 'package:myapp/demo/class1/demo1.dart';
import 'package:myapp/demo/class1/basic_appbar.dart';
import 'package:myapp/demo/class1/tabbed_appbar.dart';
import 'package:myapp/demo/class1/appBar_bottom.dart';

// 创建类别 (类别名称 + 类别图标)
class MyAppDemoCategory {
  const MyAppDemoCategory._({ this.name, this.icon });
  @required final String name;
  @required final IconData icon;

  @override
  bool operator == (dynamic other) {
    if (identical(this, other))
      return true;
    if (runtimeType != other.runtimeType)
      return false;
    final MyAppDemoCategory typedOther = other;
    return typedOther.name == name && typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(name, icon);

  @override
  String toString() {
    return '$runtimeType($name)';
  }
}

//类别1
const MyAppDemoCategory _kClass1 = MyAppDemoCategory._(
  name: '学习1',
  icon: MyAppIcons.animation,
);
//类别2
const MyAppDemoCategory _kClass2 = MyAppDemoCategory._(
  name: '学习2',
  icon: MyAppIcons.custom_typography,
);
//类别3
const MyAppDemoCategory _kClass3 = MyAppDemoCategory._(
  name: '学习3',
  icon: MyAppIcons.category_mdc,
);
//类别4
const MyAppDemoCategory _kClass4 = MyAppDemoCategory._(
  name: '学习4',
  icon: MyAppIcons.phone_iphone,
);

class MyAppDemo {
  const MyAppDemo({
    @required this.title,
    @required this.icon,
    this.subtitle,
    @required this.category,
    @required this.routeName,
    this.documentationUrl,
    @required this.buildRoute,
  }) : assert(title != null),
       assert(category != null),
       assert(routeName != null),
       assert(buildRoute != null);

  final String title; // 标题
  final IconData icon; // 标题图标
  final String subtitle; // 副标题
  final MyAppDemoCategory category; // 所属类型（类型名称+类型图标）
  final String routeName; // 路由字符串
  final WidgetBuilder buildRoute; // 路由对应的Widget
  final String documentationUrl; // 对应的文档URL

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

// 创建列表
List<MyAppDemo> _buildMyAppDemos(){
  final List<MyAppDemo> myAppDemos = <MyAppDemo>[
    MyAppDemo(
      title: '列表展示图片',
      subtitle: '布局练习',
      icon: MyAppIcons.backdrop,
      category: _kClass1,
      routeName: BackdropDemo.routeName,
      buildRoute: (BuildContext context) => BackdropDemo(),
    ),
    MyAppDemo(
      title: '底部栏',
      subtitle: '底部栏练习',
      icon: MyAppIcons.bottom_app_bar,
      category: _kClass2,
      routeName: BottomAppBarDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/BottomAppBar-class.html',
      buildRoute: (BuildContext context) => BottomAppBarDemo(),
    ),
    MyAppDemo(
      title: '导航栏',
      subtitle: '导航栏练习',
      icon: MyAppIcons.bottom_navigation,
      category: _kClass3,
      routeName: BottomNavigationDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html',
      buildRoute: (BuildContext context) => BottomNavigationDemo(),
    ),
    MyAppDemo(
      title: '卡片实例',
      subtitle: '卡片练习',
      icon: MyAppIcons.bottom_navigation,
      category: _kClass4,
      routeName: CardsDemo.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Card-class.html',
      buildRoute: (BuildContext context) => CardsDemo(),
    ),
    MyAppDemo(
      title: 'AppBar 基础',
      subtitle: '一个典型的AppBar，带有标题、操作和溢出的下拉菜单。',
      icon: MyAppIcons.bottom_navigation,
      category: _kClass1,
      routeName: BasicAppBarSample.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Card-class.html',
      buildRoute: (BuildContext context) => BasicAppBarSample(),
    ),
    MyAppDemo(
      title: '选项卡式的AppBar',
      subtitle: '一个以TabBar作为底部widget的AppBar。',
      icon: MyAppIcons.bottom_navigation,
      category: _kClass1,
      routeName: TabbedAppBarSample.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Card-class.html',
      buildRoute: (BuildContext context) => TabbedAppBarSample(),
    ),
    MyAppDemo(
      title: '具有自定义底部widget的AppBar',
      subtitle: '任何具有PreferredSize的widget都可以出现在AppBar的底部。',
      icon: MyAppIcons.bottom_navigation,
      category: _kClass1,
      routeName: AppBarBottomSample.routeName,
      documentationUrl: 'https://docs.flutter.io/flutter/material/Card-class.html',
      buildRoute: (BuildContext context) => AppBarBottomSample(),
    ),
  ];

  // 动态添加一个菜单项
  assert(() {
    myAppDemos.insert(0,
      MyAppDemo(
        title: 'Pesto',
        subtitle: 'Simple recipe browser',
        icon: Icons.adjust,
        category: _kClass1,
        routeName: Demo1.routeName,
        buildRoute: (BuildContext context) => Demo1(),
      ),
    );
    return true;
  }());

  return myAppDemos;
}

final List<MyAppDemo> kAllMyAppDemos = _buildMyAppDemos();

// 分类集合 数据项
final Set<MyAppDemoCategory> kAllGalleryDemoCategories =
  kAllMyAppDemos.map<MyAppDemoCategory>((MyAppDemo demo) => demo.category).toSet();

// 分类集合对应的 菜单项 集合
final Map<MyAppDemoCategory, List<MyAppDemo>> kGalleryCategoryToDemos =
  Map<MyAppDemoCategory, List<MyAppDemo>>.fromIterable(
    kAllGalleryDemoCategories,
    value: (dynamic category) {
      return kAllMyAppDemos.where((MyAppDemo demo) => demo.category == category).toList();
    },
  );

final Map<String, String> kDemoDocumentationUrl =
    Map<String, String>.fromIterable(
      kAllMyAppDemos.where((MyAppDemo demo) => demo.documentationUrl != null),
      key: (dynamic demo) => demo.routeName,
      value: (dynamic demo) => demo.documentationUrl,
    );