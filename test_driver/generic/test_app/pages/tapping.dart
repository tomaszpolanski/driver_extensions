import 'package:flutter/material.dart';

class TappingPage extends StatefulWidget {
  const TappingPage({Key key}) : super(key: key);

  @override
  _TappingPageState createState() => _TappingPageState();
}

class _TappingPageState extends State<TappingPage> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _tapped ? 'Tapped' : 'Not Tapped',
          key: const Key('tapped-label'),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              _tapped = true;
            });
          },
          child: const Text('Tap'),
        ),
      ],
    );
  }
}
