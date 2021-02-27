import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

typedef RunApp = FutureOr<void> Function();

abstract class IErrorReportRepository {
  Future<void> init({
    @required RunApp runApp,
  });

  Future<void> reportException({
    @required Exception exception,
    StackTrace stackTrace,
  });

  NavigatorObserver getNavigationObserver();
}
