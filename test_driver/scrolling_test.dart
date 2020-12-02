import 'dart:convert';

import 'package:driver_extensions/driver_extensions.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fast_flutter_driver/tool.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'generic/test_app/routes.dart' as routes;
import 'generic/test_configuration.dart';

void main(List<String> args) {
  late FlutterDriver driver;
  final properties = TestProperties(args);

  setUpAll(() async {
    driver = await FlutterDriver.connect(dartVmServiceUrl: properties.vmUrl);
  });

  tearDownAll(() async {
    await driver.close();
  });

  Future<void> _restart(String route) async {
    await driver.requestData(
      json.encode(
        TestConfiguration(
          resolution: properties.resolution,
          platform: properties.platform,
          route: route,
        ),
      ),
    );
  }

  group('horizontal swiping', () {
    setUp(() async {
      await _restart(routes.horizontal_swiping_page);
    });

    test('before', () async {
      await driver.waitForElement(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page2'));
    });

    test('swipeLeft', () async {
      await driver.swipeLeft(find.text('Page1'));

      await driver.waitForElement(find.text('Page2'));
      await driver.waitForAbsentElement(find.text('Page1'));
    });

    test('swipeRight', () async {
      await driver.swipeLeft(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page1'));

      await driver.swipeRight(find.text('Page2'));
      await driver.waitForElement(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page2'));
    });
  });

  group('vertical scrolling', () {
    setUp(() async {
      await _restart(routes.vertical_swiping_page);
    });

    test('before', () async {
      await driver.waitForElement(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page2'));
    });

    test('swipeDown', () async {
      await driver.swipeDown(find.text('Page1'));

      await driver.waitForElement(find.text('Page2'));
      await driver.waitForAbsentElement(find.text('Page1'));
    });

    test('swipeUp', () async {
      await driver.swipeDown(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page1'));

      await driver.swipeUp(find.text('Page2'));
      await driver.waitForElement(find.text('Page1'));
      await driver.waitForAbsentElement(find.text('Page2'));
    });
  });
}
