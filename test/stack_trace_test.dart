import 'package:driver_extensions/src/stack_trace.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_trace/stack_trace.dart';

void main() {
  group('testFileName', () {
    test('returns file name', () {
      final result = currentTestFile(StackTrace.current);

      expect(result, startsWith('stack_trace_test.dart'));
    });

    test('return null if not found', () {
      final result = currentTestFile(Chain([]));

      expect(result, isNull);
    });
  });
}
