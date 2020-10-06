import 'package:mobx/mobx.dart';

import 'package:flutter_starter_template/utils/enums.dart';

LoadingStatus mapObservableFutureToStatus(ObservableFuture future) {
  final status = future?.status;
  if (status == null || status == FutureStatus.pending) {
    return LoadingStatus.loading;
  } else if (status == FutureStatus.fulfilled) {
    return LoadingStatus.success;
  } else {
    return LoadingStatus.error;
  }
}
