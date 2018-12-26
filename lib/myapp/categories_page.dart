import 'package:flutter/material.dart';
import 'demos.dart';
import 'dart:math' as math;

const Color _kFlutterBlue = Color(0xFF003D75);

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key key,
    this.category,
    this.onTap,
  }) : super (key: key);

  final MyAppDemoCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // This repaint boundary prevents the entire _CategoriesPage from being
    // repainted when the button's ink splash animates.
    return RepaintBoundary(
      child: RawMaterialButton(
        padding: EdgeInsets.zero,
        splashColor: theme.primaryColor.withOpacity(0.12),
        highlightColor: Colors.transparent,
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                category.icon,
                size: 60.0,
                color: isDark ? Colors.white : _kFlutterBlue,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 48.0,
              alignment: Alignment.center,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.subhead.copyWith(
                  fontFamily: 'GoogleSans',
                  color: isDark ? Colors.white : _kFlutterBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({
    Key key,
    this.categories,
    this.onCategoryTap,
  }) : super(key: key);

  final Iterable<MyAppDemoCategory> categories;
  final ValueChanged<MyAppDemoCategory> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 160.0 / 180.0;
    final List<MyAppDemoCategory> categoriesList = categories.toList();
    final int columnCount = (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      label: 'categories',
      explicitChildNodes: true,
      child: SingleChildScrollView(
        key: const PageStorageKey<String>('categories'),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double columnWidth = constraints.biggest.width / columnCount.toDouble();
            final double rowHeight = math.min(225.0, columnWidth * aspectRatio);
            final int rowCount = (categories.length + columnCount - 1) ~/ columnCount;

            return RepaintBoundary(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List<Widget>.generate(rowCount, (int rowIndex) {
                  final int columnCountForRow = rowIndex == rowCount - 1
                    ? categories.length - columnCount * math.max(0, rowCount - 1)
                    : columnCount;

                  return Row(
                    children: List<Widget>.generate(columnCountForRow, (int columnIndex) {
                      final int index = rowIndex * columnCount + columnIndex;
                      final MyAppDemoCategory category = categoriesList[index];

                      return SizedBox(
                        width: columnWidth,
                        height: rowHeight,
                        child: _CategoryItem(
                          category: category,
                          onTap: () {
                            onCategoryTap(category);
                          },
                        ),
                      );
                    }),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}