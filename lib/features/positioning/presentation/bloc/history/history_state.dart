import 'package:equatable/equatable.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<Position> positions;
  final String? message;

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.positions = const [],
    this.message,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    List<Position>? positions,
    String? message,
  }) {
    return HistoryState(
      status: status ?? this.status,
      positions: positions ?? this.positions,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, positions, message];
}
