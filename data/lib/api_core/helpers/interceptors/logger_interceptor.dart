import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger _logger = Logger(
    filter: _LogFilter(),
    output: _LogOutput(logOutputs: <LogOutput>[ConsoleOutput()]),
    printer: _LogPrinter(className: 'LOGGER'),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('ERROR - ${err.type} ${err.message}');
    _logger.e('ERROR END');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final String headers = options.headers.entries
          .map((MapEntry<String, dynamic> e) => '${e.key} : ${e.value}')
          .join('\n');
      _logger.i('REQUEST -> ${options.method} ${options.uri}\n$headers');
      if (options.data != null) {
        _logger.i(options.data);
      }
      _logger.i('REQUEST END');
    } catch (e) {
      _logger.e(e);
    }
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final RequestOptions base = response.requestOptions;
    final String headers = base.headers.entries
        .map((MapEntry<String, dynamic> e) => '${e.key} : ${e.value}')
        .join('\n');
    Level level = Level.info;
    if ((response.statusCode ?? 0) >= 400) {
      level = Level.error;
    }
    _logger.log(level,
        'RESPONSE <- ${response.statusCode} ${base.method} ${base.uri}\n$headers');
    if (response.data != null) {
      _logger.log(level, response.data);
    }
    _logger.log(level, 'RESPONSE END');
    handler.next(response);
  }
}

class _LogPrinter extends PrettyPrinter {
  final String className;

  _LogPrinter({required this.className});

  @override
  List<String> log(LogEvent event) {
    final String? emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final String output = '$emoji $className - ${event.message}';
    final List<String> result = <String>[];
    output.split('\n').forEach(result.add);
    return result;
  }
}

class _LogOutput extends LogOutput {
  final List<LogOutput> logOutputs;

  _LogOutput({required this.logOutputs});

  @override
  void output(OutputEvent event) {
    for (final LogOutput logOutput in logOutputs) {
      logOutput.output(event);
    }
  }
}

class _LogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}
