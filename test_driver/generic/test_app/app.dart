import 'package:flutter/material.dart';

import 'pages/page_1.dart';
import 'pages/page_2.dart';
import 'pages/page_3.dart';
import 'pages/page_4.dart';
import 'routes.dart' as routes;

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key key, this.route}) : super(key: key);

  final String route;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: route,
      routes: {
        routes.page1: (_) => const Page1(),
        routes.page2: (_) => const Page2(),
        routes.page3: (_) => const Page3(),
        routes.page4: (_) => const Page4(),
      },
    );
  }
}
