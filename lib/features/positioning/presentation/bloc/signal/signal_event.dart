import 'package:equatable/equatable.dart';

abstract class SignalEvent extends Equatable {
  const SignalEvent();
  @override
  List<Object?> get props => [];
}

class SignalScanStarted extends SignalEvent {
  const SignalScanStarted();
}

class SignalScanStopped extends SignalEvent {
  const SignalScanStopped();
}
