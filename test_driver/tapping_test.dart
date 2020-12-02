import 'dart:convert';

import 'package:driver_extensions/driver_extensions.dart';
import 'package:fast_flutter_driver/tool.dart';
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

  group('tapping', () {
    setUp(() async {
      await _restart(routes.tapping_page);
    });
    test('before', () async {
      await driver.waitForElement(find.text('Not Tapped'));
    });

    test('after', () async {
      await driver.tapElement(find.text('Tap'));

      await driver.waitForElement(find.text('Tapped'));
    });
  });

  group('long pressing', () {
    setUp(() async {
      await _restart(routes.long_pressing_page);
    });
    test('before', () async {
      await driver.waitForElement(find.text('Not Pressed'));
    });

    test('after', () async {
      await driver.longPress(find.text('Long Press'));

      await driver.waitForElement(find.text('Pressed'));
    });
  });
}
