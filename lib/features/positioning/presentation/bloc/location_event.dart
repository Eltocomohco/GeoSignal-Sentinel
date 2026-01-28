import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationStarted extends LocationEvent {
  const LocationStarted();
}

class LocationStopped extends LocationEvent {
  const LocationStopped();
}
