import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:booster/domain/core/i_error_report_repository.dart';

class FakeErrorReportRepository implements IErrorReportRepository {
  @override
  NavigatorObserver getNavigationObserver() => NavigatorObserver();

  @override
  Future<void> init({
    @required RunApp runApp,
  }) async {
    runApp();
  }

  @override
  Future<void> reportException({
    @required Exception exception,
    StackTrace stackTrace,
  }) {
    return Future.value();
  }
}
