import 'package:flutter/material.dart';
import 'package:myapp/model/choice.dart';

class ChoiceCard extends StatelessWidget {

  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;

    return new Card(
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle,),
          ],
        ),
      ),
    );
  }
}