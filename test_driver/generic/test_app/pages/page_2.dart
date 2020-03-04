import 'package:flutter/material.dart';

import '../routes.dart' as routes;
import 'base_page.dart';

class Page2 extends StatelessWidget {
  const Page2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: routes.long_pressing_page,
      color: Colors.purpleAccent,
    );
  }
}
