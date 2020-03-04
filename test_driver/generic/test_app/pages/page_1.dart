import 'package:flutter/material.dart';

import '../routes.dart' as routes;
import 'base_page.dart';

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: routes.page1,
      color: Colors.amberAccent,
    );
  }
}
