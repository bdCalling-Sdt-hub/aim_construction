import 'package:logger/logger.dart';


class LoggerUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  /// Log a debug message
  static void debug(dynamic message) {
    _logger.d(message);
  }

  /// Log an info message
  static void info(dynamic message) {
    _logger.i(message);
  }

  /// Log a warning message
  static void warning(dynamic message) {
    _logger.w(message);
  }

  /// Log an error message
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a verbose message
  static void verbose(dynamic message) {
    _logger.v(message);
  }

  /// Log a wtf (what a terrible failure) message
  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}