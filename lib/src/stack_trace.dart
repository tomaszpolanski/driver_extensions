String testFileName(StackTrace stackTrace) {
  return RegExp(r'([a-z-_]+_test.dart:.*)\)')
      .firstMatch(stackTrace.toString())
      ?.group(1);
}
