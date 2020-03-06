/// Retrieves test files name and line from the stacktrace.
String testFileName(StackTrace stackTrace) {
  return RegExp(r'([a-z-_]+_test.dart:.*)\)')
      .firstMatch(stackTrace.toString())
      ?.group(1);
}
