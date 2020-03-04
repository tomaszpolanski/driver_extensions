import 'package:flutter/material.dart';

import 'pages/long_pressing.dart';
import 'pages/page_3.dart';
import 'pages/page_4.dart';
import 'pages/tapping.dart';
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
        routes.tapping_page: (_) => const TappingPage(),
        routes.long_pressing_page: (_) => const LongPressingPage(),
        routes.page3: (_) => const Page3(),
        routes.page4: (_) => const Page4(),
      },
    );
  }
}
