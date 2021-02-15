import 'dart:io';

import 'package:dio/dio.dart';

import 'package:booster/domain/connection/i_request_retry_scheduler.dart';

class RequestRetryInterceptor extends Interceptor {
  final IRequestRetryScheduler _retryScheduler;
  final Dio _dio;

  RequestRetryInterceptor(this._retryScheduler, this._dio);

  @override
  Future onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        final builder = _RetryRequestFunctionBuilder(_dio, err.request);
        return _retryScheduler.scheduleRequestRetry<Response>(builder.retryRequest);
      } catch (error) {
        return error;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT && err.error != null && err.error is SocketException;
  }
}

class _RetryRequestFunctionBuilder {
  final RequestOptions _options;
  final Dio _dio;

  const _RetryRequestFunctionBuilder(this._dio, this._options);

  Future<Response> retryRequest() {
    return _dio.requestUri(
      _options.uri,
      data: _options.data,
      cancelToken: _options.cancelToken,
      options: _options,
      onReceiveProgress: _options.onReceiveProgress,
      onSendProgress: _options.onSendProgress,
    );
  }
}
