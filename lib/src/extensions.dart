import 'package:driver_extensions/src/colorizing.dart';
import 'package:driver_extensions/src/stack_trace.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';

extension DriverExtensions on FlutterDriver {
  Future<void> tapElement(
    SerializableFinder finder, {
    Duration timeout,
  }) =>
      wrapper(tap, finder, timeout: timeout);

  Future<void> longPress(
    SerializableFinder finder, {
    Duration timeout,
  }) =>
      _scroll(
        this,
        finder,
        0,
        0,
        duration: const Duration(seconds: 1),
        timeout: timeout,
      );

  Future<void> waitForElement(
    SerializableFinder finder, {
    Duration timeout,
  }) =>
      wrapper(waitFor, finder, timeout: timeout);

  Future<void> waitForAbsentElement(
    SerializableFinder finder, {
    Duration timeout,
  }) =>
      wrapper(waitForAbsent, finder, timeout: timeout);

  Future<String> getElementText(
    SerializableFinder finder, {
    Duration timeout,
  }) =>
      wrapper(getText, finder, timeout: timeout);

  Future<void> swipeLeft(SerializableFinder element) async {
    await waitForElement(element);
    await _scroll(this, element, -1000, 0);
  }

  Future<void> swipeRight(SerializableFinder element) async {
    await waitForElement(element);
    await _scroll(this, element, 1000, 0);
  }

  Future<void> swipeDown(SerializableFinder element, [double distance]) {
    return _scroll(this, element, 0, -(distance ?? 1000).abs());
  }

  Future<void> swipeUp(SerializableFinder element, [double distance]) {
    return _scroll(this, element, 0, (distance ?? 1000).abs());
  }

  Future<void> scrollTo(SerializableFinder item, {SerializableFinder on}) =>
      scrollUntilVisible(item, on);
}

Future<void> _scroll(
  FlutterDriver driver,
  SerializableFinder finder,
  double dx,
  double dy, {
  Duration duration = const Duration(milliseconds: 300),
  Duration timeout,
}) {
  return _warnIfSlow(
    future: driver.scroll(finder, dx, dy, duration),
    timeout: timeout ?? const Duration(seconds: 4),
    finder: finder,
  );
}

Future<T> _warnIfSlow<T>({
  @required Future<T> future,
  @required Duration timeout,
  @required SerializableFinder finder,
}) {
  assert(future != null);
  assert(timeout != null);
  assert(finder != null);
  final stack = StackTrace.current;
  return future
    ..timeout(timeout, onTimeout: () {
      final testFile = testFileName(stack) ?? 'UNKNOWN file';
      // ignore: avoid_print
      print('Looking for \"${red(finder.serialize().toString())}\" at '
          '${bold(testFile)} takes longer than expected...');
      return null;
    });
}

Future<T> wrapper<T>(
  Future<T> Function(SerializableFinder) driverFunc,
  SerializableFinder finder, {
  Duration timeout,
}) {
  return _warnIfSlow(
    future: driverFunc(finder),
    timeout: timeout ?? const Duration(seconds: 8),
    finder: finder,
  );
}
