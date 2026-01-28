import 'package:equatable/equatable.dart';
import '../../../domain/entities/wifi_network.dart';

enum SignalStatus { initial, scanning, failure }

class SignalState extends Equatable {
  final SignalStatus status;
  final List<WifiNetwork> networks;
  final String? errorMessage;

  const SignalState({
    this.status = SignalStatus.initial,
    this.networks = const [],
    this.errorMessage,
  });

  SignalState copyWith({
    SignalStatus? status,
    List<WifiNetwork>? networks,
    String? errorMessage,
  }) {
    return SignalState(
      status: status ?? this.status,
      networks: networks ?? this.networks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, networks, errorMessage];
}
