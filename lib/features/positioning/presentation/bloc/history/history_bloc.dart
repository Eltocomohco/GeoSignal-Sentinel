import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geosignal_sentinel/features/positioning/domain/usecases/get_history_usecase.dart';
import 'package:geosignal_sentinel/features/positioning/domain/usecases/export_history_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUseCase _getHistory;
  final ExportHistoryUseCase _exportHistory;

  HistoryBloc({
    required GetHistoryUseCase getHistory,
    required ExportHistoryUseCase exportHistory,
  })  : _getHistory = getHistory,
        _exportHistory = exportHistory,
        super(const HistoryState()) {
    on<HistoryLoaded>(_onLoaded);
    on<HistoryExported>(_onExported);
  }

  Future<void> _onLoaded(HistoryLoaded event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final result = await _getHistory();
    result.fold(
      (failure) => emit(state.copyWith(status: HistoryStatus.failure, message: failure.message)),
      (positions) => emit(state.copyWith(status: HistoryStatus.success, positions: positions)),
    );
  }

  Future<void> _onExported(HistoryExported event, Emitter<HistoryState> emit) async {
    if (state.positions.isEmpty) return;
    
    // Podemos emitir un estado de "Exporting..." si fuera un proceso muy largo
    final result = await _exportHistory(state.positions);
    result.fold(
       (failure) => emit(state.copyWith(message: "Export Failed: ${failure.message}")), // Podríamos usar un status específico o Listeners
       (_) => emit(state.copyWith(message: "Export Successful")), 
    );
  }
}
