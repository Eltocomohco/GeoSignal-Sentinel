import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}

class HistoryLoaded extends HistoryEvent {
  const HistoryLoaded();
}

class HistoryExported extends HistoryEvent {
  const HistoryExported();
}
