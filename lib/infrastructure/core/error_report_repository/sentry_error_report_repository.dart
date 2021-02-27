import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:booster/domain/core/i_error_report_repository.dart';

class SentryErrorReportRepository implements IErrorReportRepository {
  final String dsn;

  const SentryErrorReportRepository({
    @required this.dsn,
  });

  @override
  Future<void> init({
    @required RunApp runApp,
  }) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
      },
      appRunner: runApp,
    );
  }

  @override
  Future<void> reportException({
    @required Exception exception,
    StackTrace stackTrace,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }

  @override
  NavigatorObserver getNavigationObserver() => SentryNavigatorObserver();
}
