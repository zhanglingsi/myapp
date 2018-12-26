import 'package:flutter/material.dart';

import 'demos.dart';
import 'dart:developer';

const Color _kFlutterBlue = Color(0xFF003D75);
const double _kDemoItemHeight = 64.0;

class _DemoItem extends StatelessWidget {
  const _DemoItem({ Key key, this.demo }) : super(key: key);

  final MyAppDemo demo;

  void _launchDemo(BuildContext context) {
    if (demo.routeName != null) {
      Timeline.instantSync('Start Transition', arguments: <String, String>{
        'from': '/',
        'to': demo.routeName,
      });
      Navigator.pushNamed(context, demo.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);

    final List<Widget> titleChildren = <Widget>[
      Text(
        demo.title,
        style: theme.textTheme.subhead.copyWith(
          color: isDark ? Colors.white : const Color(0xFF202124),
        ),
      ),
    ];
    if (demo.subtitle != null) {
      titleChildren.add(
        Text(
          demo.subtitle,
          style: theme.textTheme.body1.copyWith(
            color: isDark ? Colors.white : const Color(0xFF60646B)
          ),
        ),
      );
    }

    return RawMaterialButton(
      padding: EdgeInsets.zero,
      splashColor: theme.primaryColor.withOpacity(0.12),
      highlightColor: Colors.transparent,
      onPressed: () {
        _launchDemo(context);
      },
      child: Container(
        constraints: BoxConstraints(minHeight: _kDemoItemHeight * textScaleFactor),
        child: Row(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              alignment: Alignment.center,
              child: Icon(
                demo.icon,
                size: 24.0,
                color: isDark ? Colors.white : _kFlutterBlue,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: titleChildren,
              ),
            ),
            const SizedBox(width: 44.0),
          ],
        ),
      ),
    );
  }
}

class DemosPage extends StatelessWidget {
  const DemosPage(this.category);

  final MyAppDemoCategory category;

  @override
  Widget build(BuildContext context) {
    // When overriding ListView.padding, it is necessary to manually handle
    // safe areas.
    final double windowBottomPadding = MediaQuery.of(context).padding.bottom;
    return KeyedSubtree(
      key: const ValueKey<String>('GalleryDemoList'), // So the tests can find this ListView
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: category.name,
        explicitChildNodes: true,
        child: ListView(
          key: PageStorageKey<String>(category.name),
          padding: EdgeInsets.only(top: 8.0, bottom: windowBottomPadding),
          children: kGalleryCategoryToDemos[category].map<Widget>((MyAppDemo demo) {
            return _DemoItem(demo: demo);
          }).toList(),
        ),
      ),
    );
  }
}