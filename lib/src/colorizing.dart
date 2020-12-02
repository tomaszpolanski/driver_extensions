import 'package:driver_extensions/src/colorize/colorize.dart';
import 'package:driver_extensions/src/colorize/styles.dart';

/// Colorizes text in green.
Colorize green(String text) => Colorize(text).apply(Styles.LIGHT_GREEN);

/// Colorizes text in yellow.
Colorize yellow(String text) => Colorize(text).apply(Styles.LIGHT_YELLOW);

/// Colorizes text in red.
Colorize red(String text) => Colorize(text).apply(Styles.LIGHT_RED);

/// Makes the text bold.
Colorize bold(String text) => Colorize(text).apply(Styles.BOLD);
