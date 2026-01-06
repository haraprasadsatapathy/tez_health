import 'dart:convert';
import 'package:dio/dio.dart';

class PrettyDioLogger extends Interceptor {
  PrettyDioLogger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final StringBuffer logBuffer = StringBuffer();

    logBuffer.writeln(_colorize('\n╔══════════════════════════════════════════════════════════════', _AnsiColor.blue));
    logBuffer.writeln(_colorize('║ 📤 REQUEST', _AnsiColor.blue));
    logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.blue));
    logBuffer.writeln(_colorize('║ ${options.method} ${options.uri}', _AnsiColor.blue));
    logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.blue));

    if (options.headers.isNotEmpty) {
      logBuffer.writeln(_colorize('║ Headers:', _AnsiColor.blue));
      options.headers.forEach((key, value) {
        logBuffer.writeln(_colorize('║   $key: $value', _AnsiColor.blue));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.blue));
    }

    if (options.queryParameters.isNotEmpty) {
      logBuffer.writeln(_colorize('║ Query Parameters:', _AnsiColor.blue));
      options.queryParameters.forEach((key, value) {
        logBuffer.writeln(_colorize('║   $key: $value', _AnsiColor.blue));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.blue));
    }

    if (options.data != null) {
      logBuffer.writeln(_colorize('║ Body:', _AnsiColor.blue));
      final prettyData = _prettyPrintJson(options.data);
      prettyData.split('\n').forEach((line) {
        logBuffer.writeln(_colorize('║ $line', _AnsiColor.blue));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.blue));
    }

    logBuffer.writeln(_colorize('╚══════════════════════════════════════════════════════════════\n', _AnsiColor.blue));

    print(logBuffer.toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final StringBuffer logBuffer = StringBuffer();

    logBuffer.writeln(_colorize('\n╔══════════════════════════════════════════════════════════════', _AnsiColor.green));
    logBuffer.writeln(_colorize('║ 📥 RESPONSE', _AnsiColor.green));
    logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.green));
    logBuffer.writeln(_colorize('║ ${response.requestOptions.method} ${response.requestOptions.uri}', _AnsiColor.green));
    logBuffer.writeln(_colorize('║ Status Code: ${response.statusCode} ${response.statusMessage ?? ''}', _AnsiColor.green));
    logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.green));

    if (response.headers.map.isNotEmpty) {
      logBuffer.writeln(_colorize('║ Response Headers:', _AnsiColor.green));
      response.headers.map.forEach((key, value) {
        logBuffer.writeln(_colorize('║   $key: ${value.join(', ')}', _AnsiColor.green));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.green));
    }

    if (response.data != null) {
      logBuffer.writeln(_colorize('║ Response Data:', _AnsiColor.green));
      final prettyData = _prettyPrintJson(response.data);
      prettyData.split('\n').forEach((line) {
        logBuffer.writeln(_colorize('║ $line', _AnsiColor.green));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.green));
    }

    logBuffer.writeln(_colorize('╚══════════════════════════════════════════════════════════════\n', _AnsiColor.green));

    print(logBuffer.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final StringBuffer logBuffer = StringBuffer();

    logBuffer.writeln(_colorize('\n╔══════════════════════════════════════════════════════════════', _AnsiColor.red));
    logBuffer.writeln(_colorize('║ ❌ ERROR', _AnsiColor.red));
    logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.red));
    logBuffer.writeln(_colorize('║ ${err.requestOptions.method} ${err.requestOptions.uri}', _AnsiColor.red));
    logBuffer.writeln(_colorize('║ Error Type: ${err.type}', _AnsiColor.red));
    logBuffer.writeln(_colorize('║ Error Message: ${err.message}', _AnsiColor.red));

    if (err.response != null) {
      logBuffer.writeln(_colorize('║ Status Code: ${err.response?.statusCode}', _AnsiColor.red));
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.red));

      if (err.response?.data != null) {
        logBuffer.writeln(_colorize('║ Error Response Data:', _AnsiColor.red));
        final prettyData = _prettyPrintJson(err.response?.data);
        prettyData.split('\n').forEach((line) {
          logBuffer.writeln(_colorize('║ $line', _AnsiColor.red));
        });
        logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.red));
      }
    }

    if (err.stackTrace != null) {
      logBuffer.writeln(_colorize('║ Stack Trace:', _AnsiColor.red));
      final stackTraceLines = err.stackTrace.toString().split('\n').take(5);
      stackTraceLines.forEach((line) {
        logBuffer.writeln(_colorize('║ $line', _AnsiColor.red));
      });
      logBuffer.writeln(_colorize('╠══════════════════════════════════════════════════════════════', _AnsiColor.red));
    }

    logBuffer.writeln(_colorize('╚══════════════════════════════════════════════════════════════\n', _AnsiColor.red));

    print(logBuffer.toString());
    super.onError(err, handler);
  }

  String _prettyPrintJson(dynamic data) {
    try {
      if (data is String) {
        try {
          final jsonData = jsonDecode(data);
          return const JsonEncoder.withIndent('  ').convert(jsonData);
        } catch (e) {
          return data;
        }
      } else if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      } else {
        return data.toString();
      }
    } catch (e) {
      return data.toString();
    }
  }

  String _colorize(String text, _AnsiColor color) {
    return '${color.code}$text${_AnsiColor.reset.code}';
  }
}

enum _AnsiColor {
  reset('\x1B[0m'),
  blue('\x1B[34m'),
  green('\x1B[32m'),
  red('\x1B[31m'),
  yellow('\x1B[33m'),
  cyan('\x1B[36m'),
  magenta('\x1B[35m');

  final String code;
  const _AnsiColor(this.code);
}
