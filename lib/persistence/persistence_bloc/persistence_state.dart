import 'package:equatable/equatable.dart';

abstract class PersistenceState extends Equatable {
  const PersistenceState();
}

class InitialPersistenceState extends PersistenceState {
  @override
  List<Object> get props => [];
}
