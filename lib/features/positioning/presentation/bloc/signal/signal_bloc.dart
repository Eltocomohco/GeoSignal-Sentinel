import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../domain/repositories/signal_repository.dart';
import 'signal_event.dart';
import 'signal_state.dart';

class SignalBloc extends Bloc<SignalEvent, SignalState> {
  final SignalRepository _repository;

  SignalBloc({required SignalRepository repository})
      : _repository = repository,
        super(const SignalState()) {
    
    // Usamos restartable para reiniciar el stream si se vuelve a pedir inicio
    on<SignalScanStarted>(_onScanStarted, transformer: restartable());
    on<SignalScanStopped>(_onScanStopped);
  }

  Future<void> _onScanStarted(
    SignalScanStarted event,
    Emitter<SignalState> emit,
  ) async {
    emit(state.copyWith(status: SignalStatus.scanning));

    await emit.forEach(
      _repository.getWifiScanStream(),
      onData: (result) => result.fold(
        (failure) => state.copyWith(
          status: SignalStatus.failure,
          errorMessage: failure.message,
        ),
        (networks) => state.copyWith(
          status: SignalStatus.scanning,
          networks: networks,
        ),
      ),
      onError: (error, stack) => state.copyWith(
        status: SignalStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  void _onScanStopped(
    SignalScanStopped event,
    Emitter<SignalState> emit,
  ) {
    // Al emitir un nuevo estado sin consumir el stream, el transformer restartable
    // y la naturaleza de emit.forEach deberían manejar la cancelación si cambiamos de evento,
    // pero para ser explícitos y "limpios":
    emit(state.copyWith(status: SignalStatus.initial, networks: []));
  }
}
