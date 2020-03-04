import 'package:flutter/material.dart';

import '../routes.dart' as routes;
import 'base_page.dart';

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: routes.page4,
      color: Colors.greenAccent,
    );
  }
}
