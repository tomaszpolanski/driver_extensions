import 'package:flutter/material.dart';

import '../routes.dart' as routes;
import 'base_page.dart';

class Page3 extends StatelessWidget {
  const Page3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: routes.page3,
      color: Colors.blue,
    );
  }
}
