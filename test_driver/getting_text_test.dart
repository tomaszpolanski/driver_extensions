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

  setUp(() async {
    await _restart(routes.tapping_page);
  });

  test('getting text', () async {
    final result = await driver.getElementText(
      find.byValueKey('tapped-label'),
    );

    expect(result, 'Not Tapped');
  });
}
