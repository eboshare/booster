import 'package:bloc/bloc.dart';

import 'package:booster/domain/connection/connection_event/connection_event.dart';
import 'package:booster/domain/connection/connection_state/connection_state.dart';

abstract class IConnectionBloc implements Bloc<ConnectionEvent, ConnectionState> {}
