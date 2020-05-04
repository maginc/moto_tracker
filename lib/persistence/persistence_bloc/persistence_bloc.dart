import 'dart:async';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class PersistenceBloc extends Bloc<PersistenceEvent, PersistenceState> {
  @override
  PersistenceState get initialState => InitialPersistenceState();

  @override
  Stream<PersistenceState> mapEventToState(
    PersistenceEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
