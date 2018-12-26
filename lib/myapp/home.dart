import 'package:flutter/material.dart';
import 'package:myapp/myapp/demos.dart';
import 'categories_page.dart';
import 'demos_page.dart';

const String _kGalleryAssetsPackage = 'flutter_myapp_assets';
const Color _kFlutterBlue = Color(0xFF003D75);
const double _kDemoItemHeight = 64.0;
const Duration _kFrontLayerSwitchDuration = Duration(milliseconds: 300);

class _FlutterLogo extends StatelessWidget {
  const _FlutterLogo({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 34.0,
        height: 34.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'white_logo/4.0x/logo.png',
              package: _kGalleryAssetsPackage,
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({
    Key key,
    this.testMode = false,
    // this.optionsPage,
  }) : super(key: key);

  // final Widget optionsPage;
  final bool testMode;

  // 是否显示屏幕右上角的DEBUG图标 
  static bool showPreviewBanner = true;

  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyAppDemoCategory _category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // 获取当前上下文中的主题数据
    final bool isDark = (theme.brightness == Brightness.dark);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? theme.primaryColor : _kFlutterBlue,
      appBar: AppBar(
        title: Text('My App Study'),
        backgroundColor: theme.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: (){
              print('点击了');
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            if (_category != null) {
              setState(() => _category = null);
              return Future<bool>.value(false);
            }
            return Future<bool>.value(true);
          },
          child: Container(
            color: Colors.red,
            child: Card(
              child: AnimatedSwitcher(
                duration: _kFrontLayerSwitchDuration,
                switchOutCurve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                switchInCurve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                // layoutBuilder: centerHome ? _centerHomeLayout : _topHomeLayout,
                child: _category != null ? DemosPage(_category) : CategoriesPage(
                    categories: kAllGalleryDemoCategories,
                    onCategoryTap: (MyAppDemoCategory category) {
                      setState(() => _category = category);
                    },
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}