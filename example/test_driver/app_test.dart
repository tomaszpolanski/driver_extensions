import 'package:driver_extensions/driver_extensions.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() {
    driver.close();
  });

  group('Counter App', () {
    final buttonFinder = find.byValueKey('increment');

    test('starts at 0', () async {
      await driver.waitForElement(find.text('0'));
    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tapElement(buttonFinder);

      // Then, verify the counter text is incremented by 1.
      await driver.waitForElement(find.text('1'));
    });
  });

  group('Failing tests', () {
    test(
      'prints finder and file on fail',
      () async {
        await driver.waitForElement(
          find.byValueKey('missing'),
          timeout: const Duration(seconds: 1),
        );
      },
      timeout: const Timeout(Duration(seconds: 5)),
    );

    test(
      'executes onTimeout callback',
      () async {
        bool hadTimeout = false;
        await driver.waitForElement(find.byValueKey('missing'),
            timeout: const Duration(seconds: 1), onTimeout: () async {
          // ignore: avoid_print
          print('This executes on timeout. '
              'Can create screenthosts for failing');
          hadTimeout = true;
        });

        expect(hadTimeout, isTrue);
      },
      timeout: const Timeout(Duration(seconds: 5)),
    );
  });
}
