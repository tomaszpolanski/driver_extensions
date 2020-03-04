import 'package:flutter/material.dart';

class HorizontalSwipingPage extends StatelessWidget {
  const HorizontalSwipingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Text('Page1'),
        Text('Page2'),
      ],
    );
  }
}
