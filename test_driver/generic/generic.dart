import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:fast_flutter_driver/driver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'test_app/app.dart';
import 'test_configuration.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  timeDilation = 0.1;
  enableFlutterDriverExtension(
    handler: (playload) => configureTest(
      TestConfiguration.fromJson(json.decode(playload!)),
    ),
  );

  runApp(
    RestartWidget<TestConfiguration>(
      backgroundColor: Colors.white,
      builder: (_, config) => TestApp(route: config.route),
    ),
  );
}
