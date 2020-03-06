# driver_extensions
[![](https://github.com/tomaszpolanski/driver_extensions/workflows/Analyze/badge.svg)](https://github.com/tomaszpolanski/driver_extensions/actions?query=workflow%3A%22Analyze%22)
[![pub package](https://img.shields.io/pub/v/driver_extensions.svg)](https://pub.dev/packages/driver_extensions)

A set of Flutter Driver extension methods to make driver tests easier to write and maintain.

## Reasoning 
When Flutter driver tests fail, we have not detailed enough message:
![](./images/not%20detailed.PNG)
```dart
await driver.waitFor(
  find.byValueKey('missing'),
);
```

With the extensions, you will get this message:
![](./images/detailed.PNG)
```dart
await driver.waitForElement(
  find.byValueKey('missing'),
);
```
