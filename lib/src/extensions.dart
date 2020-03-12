import 'package:driver_extensions/src/colorizing.dart';
import 'package:driver_extensions/src/stack_trace.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';

extension DriverExtensions on FlutterDriver {
  /// Taps an element described by [finder].
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> tapElement(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      wrapper(tap, finder, timeout: timeout, onTimeout: onTimeout);

  /// Long pressing an element.
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> longPress(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      _scroll(
        this,
        finder,
        0,
        0,
        duration: const Duration(seconds: 1),
        timeout: timeout,
        onTimeout: onTimeout,
      );

  /// Waits for an element to appear.
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> waitForElement(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      wrapper(waitFor, finder, timeout: timeout, onTimeout: onTimeout);

  /// Waits for an element to disappear.
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> waitForAbsentElement(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      wrapper(waitForAbsent, finder, timeout: timeout, onTimeout: onTimeout);

  /// Retrieves text assigned to an [finder].
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<String> getElementText(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      wrapper(getText, finder, timeout: timeout, onTimeout: onTimeout);

  /// Presses the [element] and moves finger/pointer to the right.
  /// (moves the [element] to the left).
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> swipeLeft(
    SerializableFinder element, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      _scroll(this, element, -1000, 0, timeout: timeout, onTimeout: onTimeout);

  /// Presses the [finder] and moves finger/pointer to the left
  /// (moves the element to the right).
  /// Use [timeout] [finder] specify after what time a warning should be printed.
  Future<void> swipeRight(
    SerializableFinder finder, {
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      _scroll(this, finder, 1000, 0, timeout: timeout, onTimeout: onTimeout);

  /// Presses the [finder] and moves finger/pointer to the top.
  /// (moves the [finder] to the down).
  /// Use [finder] to specify after what time a warning should be printed.
  Future<void> swipeDown(
    SerializableFinder finder, {
    double distance,
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      _scroll(
        this,
        finder,
        0,
        -(distance ?? 1000).abs(),
        timeout: timeout,
        onTimeout: onTimeout,
      );

  /// Presses the [finder] and moves finger/pointer to the bottom.
  /// (moves the [finder] to the up).
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> swipeUp(
    SerializableFinder finder, {
    double distance,
    Duration timeout = const Duration(seconds: 5),
    Future<dynamic> Function() onTimeout,
  }) =>
      _scroll(
        this,
        finder,
        0,
        (distance ?? 1000).abs(),
        timeout: timeout,
        onTimeout: onTimeout,
      );

  /// Tries to scroll to [item] that is in [on] scrollable surface.
  /// Use [timeout] to specify after what time a warning should be printed.
  Future<void> scrollTo(
    SerializableFinder item, {
    SerializableFinder on,
    Duration timeout = const Duration(seconds: 5),
  }) =>
      scrollUntilVisible(item, on, timeout: timeout);
}

Future<void> _scroll(
  FlutterDriver driver,
  SerializableFinder finder,
  double dx,
  double dy, {
  Duration duration = const Duration(milliseconds: 300),
  @required Duration timeout,
  @required Future<dynamic> Function() onTimeout,
}) {
  return _warnIfSlow(
    future: driver.scroll(finder, dx, dy, duration),
    timeout: timeout,
    finder: finder,
    onTimeout: onTimeout,
  );
}

Future<T> _warnIfSlow<T>({
  @required Future<T> future,
  @required Duration timeout,
  @required SerializableFinder finder,
  @required Future<dynamic> Function() onTimeout,
}) {
  assert(future != null);
  assert(timeout != null);
  assert(finder != null);
  final stack = StackTrace.current;
  return future
    ..timeout(timeout, onTimeout: () async {
      final testFile = currentTestFile(stack) ?? 'UNKNOWN file';
      // ignore: avoid_print
      print('Looking for \"${red(finder.serialize().toString())}\" at '
          '${bold(testFile)} takes longer than expected...');
      return onTimeout != null ? onTimeout() : null;
    });
}

/// Helper to wrap Flutter Driver test function and prints pretty error.
Future<T> wrapper<T>(
  Future<T> Function(SerializableFinder) driverFunc,
  SerializableFinder finder, {
  @required Duration timeout,
  Future<dynamic> Function() onTimeout,
}) {
  return _warnIfSlow(
    future: driverFunc(finder),
    finder: finder,
    timeout: timeout,
    onTimeout: onTimeout,
  );
}
