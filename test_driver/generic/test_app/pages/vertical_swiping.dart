import 'package:flutter/material.dart';

class VerticalSwipingPage extends StatelessWidget {
  const VerticalSwipingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: const <Widget>[
        Text('Page1'),
        Text('Page2'),
      ],
    );
  }
}
