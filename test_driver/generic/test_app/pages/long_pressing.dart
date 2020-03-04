import 'package:flutter/material.dart';

class LongPressingPage extends StatefulWidget {
  const LongPressingPage({Key key}) : super(key: key);

  @override
  _LongPressingPageState createState() => _LongPressingPageState();
}

class _LongPressingPageState extends State<LongPressingPage> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_pressing ? 'Pressed' : 'Not Pressed'),
        GestureDetector(
          onLongPress: () {
            setState(() {
              _pressing = true;
            });
          },
          child: const Text('Long Press'),
        ),
      ],
    );
  }
}
